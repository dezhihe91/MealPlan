import SwiftUI
import Speech
import AVFoundation

struct RecipeLibraryView: View {
    private var cuisineOptions: [String] {
        let cuisines = store.allRecipes.compactMap { $0.cuisine }.filter { !$0.isEmpty }
        return Array(Set(cuisines)).sorted()
    }

    private func cuisineLabel(_ cuisine: String) -> String {
        if store.language == .english {
            let map: [String: String] = ["川菜": "Sichuan", "湘菜": "Hunan", "粤菜": "Cantonese", "家常": "Home-style"]
            return map[cuisine] ?? cuisine
        }
        return cuisine
    }

    private func filterChip(title: String, isOn: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(isOn ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.15))
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }

    private func isMeatRecipe(_ recipe: Recipe) -> Bool {
        let cnKeywords = ["鸡肉", "牛肉", "猪肉", "羊肉", "鸭肉", "排骨", "鱼", "虾", "蟹", "贝", "五花肉", "牛腩", "腊肉", "培根", "火腿", "香肠", "鱼片", "鱼头"]
        let enKeywords = ["chicken", "beef", "pork", "lamb", "duck", "rib", "fish", "shrimp", "crab", "clam", "bacon", "ham", "sausage", "steak"]
        let names = recipe.ingredients.map { $0.name.lowercased() } + [recipe.displayName(for: .english).lowercased(), recipe.displayName(for: .chinese).lowercased()]

        for name in names {
            if name.contains("鸡蛋") || name.contains("蛋") {
                // treat eggs as non-meat unless meat keyword also present
                if cnKeywords.contains(where: { name.contains($0) }) { return true }
                continue
            }
            if cnKeywords.contains(where: { name.contains($0) }) { return true }
            if enKeywords.contains(where: { name.contains($0) }) { return true }
        }
        return false
    }

    private func isSoupRecipe(_ recipe: Recipe) -> Bool {
        if recipe.isSoup { return true }
        let name = recipe.displayName(for: store.language).lowercased()
        if store.language == .chinese {
            return name.contains("汤") || name.contains("羹") || name.contains("粥")
        }
        return name.contains("soup") || name.contains("broth") || name.contains("congee")
    }

    private var filteredRecipes: [Recipe] {
        var list = store.allRecipes
        if filterLikedOnly {
            list = list.filter { store.likedIds.contains($0.id) }
        }
        if filterMeatOnly {
            list = list.filter { isMeatRecipe($0) }
        }
        if filterVegOnly {
            list = list.filter { !isMeatRecipe($0) }
        }
        if let meal = filterMeal {
            list = list.filter { $0.mealType == meal }
        }
        if !filterCuisine.isEmpty {
            list = list.filter { $0.cuisine == filterCuisine }
        }
        if filterSoupOnly {
            list = list.filter { isSoupRecipe($0) }
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
    @State private var filterLikedOnly: Bool = false
    @State private var filterMeatOnly: Bool = false
    @State private var filterVegOnly: Bool = false

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
                            Text(cuisineLabel(cuisine)).tag(cuisine)
                        }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(store.language == .chinese ? "只看" : "Only")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        HStack {
                            filterChip(title: store.language == .chinese ? "喜欢" : "Liked", isOn: filterLikedOnly) {
                                filterLikedOnly.toggle()
                            }
                            filterChip(title: store.language == .chinese ? "荤菜" : "Meat", isOn: filterMeatOnly) {
                                filterMeatOnly.toggle()
                                if filterMeatOnly { filterVegOnly = false }
                            }
                            filterChip(title: store.language == .chinese ? "素菜" : "Veg", isOn: filterVegOnly) {
                                filterVegOnly.toggle()
                                if filterVegOnly { filterMeatOnly = false }
                            }
                            filterChip(title: store.language == .chinese ? "汤品" : "Soup", isOn: filterSoupOnly) {
                                filterSoupOnly.toggle()
                            }
                        }
                    }
                }

                Section(header: Text(store.language == .chinese ? "候选菜谱" : "Candidate Pool")) {
                    let candidateRecipes = filteredRecipes.filter { store.candidateIds.contains($0.id) }
                    if candidateRecipes.isEmpty {
                        Text(store.language == .chinese ? "未选择候选菜谱" : "No candidates selected")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(candidateRecipes) { recipe in
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
                            Button(action: {
                                if store.likedIds.contains(recipe.id) {
                                    store.likedIds.remove(recipe.id)
                                } else {
                                    store.likedIds.insert(recipe.id)
                                }
                            }) {
                                Image(systemName: store.likedIds.contains(recipe.id) ? "heart.fill" : "heart")
                                    .foregroundColor(store.likedIds.contains(recipe.id) ? .red : .secondary)
                            }
                            .buttonStyle(.borderless)
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
                        .swipeActions {
                            Button(role: .destructive) {
                                store.deleteRecipe(recipe)
                            } label: {
                                Label(store.language == .chinese ? "删除" : "Delete", systemImage: "trash")
                            }
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
