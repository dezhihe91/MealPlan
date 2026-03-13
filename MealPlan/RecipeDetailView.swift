import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject var store: MealPlanStore
    let recipe: Recipe
    @State private var showingEdit = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.displayName(for: store.language))
                    .font(.title2)
                    .bold()

                if recipe.prepMinutes != nil || recipe.cookMinutes != nil {
                    let prep = recipe.prepMinutes ?? 0
                    let cook = recipe.cookMinutes ?? 0
                    let total = prep + cook
                    Text(store.language == .chinese ? "用时：准备 \(prep) 分钟 · 烹饪 \(cook) 分钟 · 合计 \(total) 分钟" : "Time: Prep \(prep) min · Cook \(cook) min · Total \(total) min")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let nutrition = recipe.displayNutrition(for: store.language) {
                    Text(nutrition)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(store.language == .chinese ? "食材准备" : "Ingredients")
                        .font(.headline)
                    let grouped = Dictionary(grouping: recipe.ingredients, by: { $0.category })
                    ForEach(IngredientCategory.allCases) { category in
                        if let items = grouped[category] {
                            Text(category.title(for: store.language))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            ForEach(items) { item in
                                Text("• \(item.displayName(for: store.language)) — \(String(format: "%.1f", item.quantity)) \(item.unit)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(store.language == .chinese ? "详细步骤" : "Instructions")
                        .font(.headline)
                    let steps = stepsFromInstructions(recipe.displayInstructions(for: store.language))
                    ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                        let line = "\(index + 1). \(step)"
                        if let attributed = try? AttributedString(markdown: line, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
                            Text(attributed)
                                .font(.body)
                        } else {
                            Text(line)
                                .font(.body)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(store.language == .chinese ? "菜谱" : "Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 12) {
                    Button(store.language == .chinese ? "编辑" : "Edit") {
                        showingEdit = true
                    }
                    Button(action: {
                        if store.likedIds.contains(recipe.id) {
                            store.likedIds.remove(recipe.id)
                        } else {
                            store.likedIds.insert(recipe.id)
                        }
                    }) {
                        Image(systemName: store.likedIds.contains(recipe.id) ? "heart.fill" : "heart")
                            .foregroundColor(store.likedIds.contains(recipe.id) ? .red : .primary)
                    }
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            EditRecipeView(recipe: recipe)
                .environmentObject(store)
        }
    }

    private func stepsFromInstructions(_ instructions: String) -> [String] {
        let separators: [Character] = ["；", "。", "\n"]
        var parts: [String] = [instructions]
        for sep in separators {
            parts = parts.flatMap { $0.split(separator: sep).map { String($0) } }
        }
        return parts.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
    }
}

struct EditRecipeView: View {
    @EnvironmentObject var store: MealPlanStore
    @Environment(\.dismiss) var dismiss

    let recipe: Recipe
    @State private var name: String
    @State private var instructions: String
    @State private var ingredientsText: String
    @State private var mealType: MealType
    @State private var isSoup: Bool
    @State private var cuisine: String

    init(recipe: Recipe) {
        self.recipe = recipe
        _name = State(initialValue: recipe.name)
        _instructions = State(initialValue: recipe.instructions)
        _ingredientsText = State(initialValue: recipe.ingredients.map { $0.name }.joined(separator: ", "))
        _mealType = State(initialValue: recipe.mealType)
        _isSoup = State(initialValue: recipe.isSoup)
        _cuisine = State(initialValue: recipe.cuisine ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
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
                    TextEditor(text: $instructions)
                        .frame(height: 160)
                }

                Text(store.language == .chinese ? "当前语言编辑会更新对应的中/英版本" : "Editing updates the current language fields.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .navigationTitle(store.language == .chinese ? "编辑菜谱" : "Edit Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(store.language == .chinese ? "取消" : "Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(store.language == .chinese ? "保存" : "Save") {
                        save()
                        dismiss()
                    }
                }
            }
        }
    }

    private func save() {
        let items = ingredientsText
            .split { $0 == "," || $0 == "\n" }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .map { Ingredient(name: $0, quantity: 1, unit: store.language == .chinese ? "份" : "serving", category: .other) }

        var updated = recipe
        if store.language == .english {
            updated = Recipe(
                name: recipe.name,
                nameEn: name,
                mealType: mealType,
                ingredients: items,
                instructions: recipe.instructions,
                instructionsEn: instructions,
                nutrition: recipe.nutrition,
                nutritionEn: recipe.nutritionEn,
                calories: recipe.calories,
                protein: recipe.protein,
                carbs: recipe.carbs,
                fat: recipe.fat,
                prepMinutes: recipe.prepMinutes,
                cookMinutes: recipe.cookMinutes,
                isSoup: isSoup,
                cuisine: cuisine.isEmpty ? nil : cuisine
            )
        } else {
            updated = Recipe(
                name: name,
                nameEn: recipe.nameEn,
                mealType: mealType,
                ingredients: items,
                instructions: instructions,
                instructionsEn: recipe.instructionsEn,
                nutrition: recipe.nutrition,
                nutritionEn: recipe.nutritionEn,
                calories: recipe.calories,
                protein: recipe.protein,
                carbs: recipe.carbs,
                fat: recipe.fat,
                prepMinutes: recipe.prepMinutes,
                cookMinutes: recipe.cookMinutes,
                isSoup: isSoup,
                cuisine: cuisine.isEmpty ? nil : cuisine
            )
        }
        store.updateRecipe(updated)
    }
}
