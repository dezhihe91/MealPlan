import SwiftUI
import Speech
import AVFoundation

struct RecipeLibraryView: View {
    private var cuisineOptions: [String] {
        let cuisines = store.allRecipes.compactMap { $0.cuisine }.filter { !$0.isEmpty }
        return Array(Set(cuisines)).sorted()
    }

    private var filteredRecipes: [Recipe] {
        var list = store.allRecipes
        if filterCandidatesOnly {
            list = list.filter { store.candidateIds.contains($0.id) }
        }
        if let meal = filterMeal {
            list = list.filter { $0.mealType == meal }
        }
        if !filterCuisine.isEmpty {
            list = list.filter { $0.cuisine == filterCuisine }
        }
        if filterSoupOnly {
            list = list.filter { $0.isSoup }
        }
        if !searchText.isEmpty {
            list = list.filter { $0.displayName(for: store.language).localizedCaseInsensitiveContains(searchText) }
        }
        return list
    }
    @EnvironmentObject var store: MealPlanStore
    @State private var showingAdd = false
    @State private var searchText: String = ""
    @State private var filterMeal: MealType? = nil
    @State private var filterCuisine: String = ""
    @State private var filterSoupOnly: Bool = false
    @State private var filterCandidatesOnly: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text(store.language == .chinese ? "筛选" : "Filters")) {
                    Picker(store.language == .chinese ? "餐别" : "Meal", selection: $filterMeal) {
                        Text(store.language == .chinese ? "全部" : "All").tag(MealType?.none)
                        ForEach(MealType.allCases) { type in
                            Text(type.title(for: store.language)).tag(Optional(type))
                        }
                    }
                    Picker(store.language == .chinese ? "菜系" : "Cuisine", selection: $filterCuisine) {
                        Text(store.language == .chinese ? "全部" : "All").tag("")
                        ForEach(cuisineOptions, id: \.self) { cuisine in
                            Text(cuisine).tag(cuisine)
                        }
                    }
                    Toggle(store.language == .chinese ? "只看汤品" : "Soup only", isOn: $filterSoupOnly)
                    Toggle(store.language == .chinese ? "只看候选" : "Candidates only", isOn: $filterCandidatesOnly)
                }

                Section(header: Text(store.language == .chinese ? "候选菜谱" : "Candidate Pool")) {
                    if store.candidateIds.isEmpty {
                        Text(store.language == .chinese ? "未选择候选菜谱" : "No candidates selected")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(store.allRecipes.filter { store.candidateIds.contains($0.id) }) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                Text(recipe.displayName(for: store.language))
                            }
                        }
                    }
                }

                Section(header: Text(store.language == .chinese ? "全部菜谱" : "All Recipes")) {
                    ForEach(filteredRecipes) { recipe in
                        HStack {
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                Text(recipe.displayName(for: store.language))
                            }
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: { store.candidateIds.contains(recipe.id) },
                                set: { isOn in
                                    if isOn {
                                        store.candidateIds.insert(recipe.id)
                                    } else {
                                        store.candidateIds.remove(recipe.id)
                                    }
                                }
                            ))
                            .labelsHidden()
                        }
                    }
                }
            }
            .navigationTitle(store.language == .chinese ? "菜谱库" : "Recipe Library")
            .searchable(text: $searchText, prompt: store.language == .chinese ? "搜索菜谱" : "Search recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddRecipeView()
                    .environmentObject(store)
            }
        }
    }
}

struct AddRecipeView: View {
    @EnvironmentObject var store: MealPlanStore
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var mealType: MealType = .lunch
    @State private var ingredientsText: String = ""
    @State private var instructionsText: String = ""
    @State private var isSoup: Bool = false
    @State private var cuisine: String = ""

    @State private var isRecording = false
    @State private var transcript: String = ""

    private let recognizer = SpeechRecognizerHelper()

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(store.language == .chinese ? "语音输入" : "Voice Input")) {
                    TextEditor(text: $transcript)
                        .frame(height: 120)
                    HStack {
                        Button(isRecording ? (store.language == .chinese ? "停止" : "Stop") : (store.language == .chinese ? "开始录音" : "Record")) {
                            if isRecording {
                                recognizer.stop()
                                isRecording = false
                                applyTranscript()
                            } else {
                                recognizer.start { text in
                                    transcript = text
                                }
                                isRecording = true
                            }
                        }
                        .buttonStyle(.borderedProminent)

                        Button(store.language == .chinese ? "解析" : "Parse") {
                            applyTranscript()
                        }
                        .buttonStyle(.bordered)
                    }
                }

                Section(header: Text(store.language == .chinese ? "基本信息" : "Basics")) {
                    TextField(store.language == .chinese ? "菜名" : "Name", text: $name)
                    Picker(store.language == .chinese ? "餐别" : "Meal", selection: $mealType) {
                        ForEach(MealType.allCases) { type in
                            Text(type.title(for: store.language)).tag(type)
                        }
                    }
                    Toggle(store.language == .chinese ? "是否汤品" : "Soup", isOn: $isSoup)
                    TextField(store.language == .chinese ? "菜系（可选）" : "Cuisine (optional)", text: $cuisine)
                }

                Section(header: Text(store.language == .chinese ? "食材（逗号分隔）" : "Ingredients (comma separated)")) {
                    TextEditor(text: $ingredientsText)
                        .frame(height: 80)
                }

                Section(header: Text(store.language == .chinese ? "步骤" : "Instructions")) {
                    TextEditor(text: $instructionsText)
                        .frame(height: 120)
                }
            }
            .navigationTitle(store.language == .chinese ? "新增菜谱" : "Add Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(store.language == .chinese ? "保存" : "Save") {
                        saveRecipe()
                        dismiss()
                    }
                }
            }
        }
        .onDisappear {
            recognizer.stop()
        }
    }

    private func applyTranscript() {
        let parsed = RecipeParser.parse(transcript: transcript)
        if let parsedName = parsed.name { name = parsedName }
        if let parsedIngredients = parsed.ingredients { ingredientsText = parsedIngredients }
        if let parsedSteps = parsed.steps { instructionsText = parsedSteps }
    }

    private func saveRecipe() {
        let ingredients = ingredientsText
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .map { Ingredient(name: $0, quantity: 1, unit: "份", category: .other) }

        let recipe = Recipe(
            name: name.isEmpty ? (store.language == .chinese ? "自定义菜谱" : "Custom Recipe") : name,
            nameEn: nil,
            mealType: mealType,
            ingredients: ingredients,
            instructions: instructionsText.isEmpty ? (store.language == .chinese ? "" : "") : instructionsText,
            instructionsEn: nil,
            nutrition: nil,
            nutritionEn: nil,
            prepMinutes: 10,
            cookMinutes: 15,
            isSoup: isSoup,
            cuisine: cuisine.isEmpty ? nil : cuisine
        )
        store.addCustomRecipe(recipe)
    }
}

final class SpeechRecognizerHelper {
    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    func start(onResult: @escaping (String) -> Void) {
        SFSpeechRecognizer.requestAuthorization { _ in }
        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request = request else { return }
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            request.append(buffer)
        }
        audioEngine.prepare()
        try? audioEngine.start()

        task = recognizer?.recognitionTask(with: request) { result, _ in
            if let result = result {
                onResult(result.bestTranscription.formattedString)
            }
        }
    }

    func stop() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        task?.cancel()
        task = nil
    }
}

struct RecipeParser {
    struct Parsed {
        var name: String?
        var ingredients: String?
        var steps: String?
    }

    static func parse(transcript: String) -> Parsed {
        var parsed = Parsed()
        let text = transcript.replacingOccurrences(of: "\n", with: " ")
        if text.contains("食材") || text.contains("步骤") {
            let parts = text.components(separatedBy: "步骤")
            if parts.count > 1 {
                parsed.steps = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
            }
            let left = parts[0]
            let parts2 = left.components(separatedBy: "食材")
            if parts2.count > 1 {
                parsed.ingredients = parts2[1].trimmingCharacters(in: .whitespacesAndNewlines)
            }
            parsed.name = parts2[0].trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            parsed.steps = text
        }
        return parsed
    }
}
