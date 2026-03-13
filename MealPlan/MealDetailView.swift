import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var store: MealPlanStore
    let dayId: UUID
    let mealType: MealType
    let recipes: [Recipe]

    @State private var showingEdit = false
    @State private var selectedIds: Set<UUID> = []

    private var summaryLabel: String {
        let totals = recipes.reduce((0,0,0,0)) { acc, item in
            let n = item.estimatedNutrition()
            return (acc.0 + n.calories, acc.1 + n.protein, acc.2 + n.carbs, acc.3 + n.fat)
        }
        let calories = totals.0
        let protein = totals.1
        let carbs = totals.2
        let fat = totals.3
        if store.language == .chinese {
            return "约 \(calories) 千卡 · 蛋白 \(protein)g · 碳水 \(carbs)g · 脂肪 \(fat)g"
        }
        return "~\(calories) kcal · P \(protein)g · C \(carbs)g · F \(fat)g"
    }

    var body: some View {
        List {
            Section {
                Text(summaryLabel)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            ForEach(recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.displayName(for: store.language))
                            .font(.headline)
                        if let cuisine = recipe.displayCuisine(for: store.language) {
                            Text(cuisine)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(mealType.title(for: store.language))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 12) {
                    Button(store.language == .chinese ? "编辑" : "Edit") {
                        selectedIds = Set(recipes.map { $0.id })
                        showingEdit = true
                    }
                    Text("\(recipes.count) \(store.language == .chinese ? "道" : "dishes")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            MealEditView(dayId: dayId, mealType: mealType, selectedIds: $selectedIds)
                .environmentObject(store)
        }
    }
}

struct MealEditView: View {
    @EnvironmentObject var store: MealPlanStore
    @Environment(\.dismiss) var dismiss

    let dayId: UUID
    let mealType: MealType
    @Binding var selectedIds: Set<UUID>
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredRecipes) { recipe in
                    Button(action: {
                        if selectedIds.contains(recipe.id) {
                            selectedIds.remove(recipe.id)
                        } else {
                            selectedIds.insert(recipe.id)
                        }
                    }) {
                        HStack {
                            Text(recipe.displayName(for: store.language))
                            Spacer()
                            if selectedIds.contains(recipe.id) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
            .navigationTitle(store.language == .chinese ? "选择菜谱" : "Select Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(store.language == .chinese ? "取消" : "Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(store.language == .chinese ? "保存" : "Save") {
                        store.updateMeal(dayId: dayId, mealType: mealType, recipeIds: selectedIds)
                        dismiss()
                    }
                }
            }
            .searchable(text: $searchText, prompt: store.language == .chinese ? "搜索菜谱" : "Search")
        }
    }

    private var filteredRecipes: [Recipe] {
        var list = store.recipesForMeal(mealType)
        if !searchText.isEmpty {
            list = list.filter { $0.displayName(for: store.language).localizedCaseInsensitiveContains(searchText) }
        }
        return list
    }
}
