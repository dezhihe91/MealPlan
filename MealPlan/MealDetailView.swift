import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var store: MealPlanStore
    let mealType: MealType
    let recipes: [Recipe]

    private var summaryLabel: String {
        let calories = recipes.compactMap { $0.calories }.reduce(0, +)
        let protein = recipes.compactMap { $0.protein }.reduce(0, +)
        let carbs = recipes.compactMap { $0.carbs }.reduce(0, +)
        let fat = recipes.compactMap { $0.fat }.reduce(0, +)
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
                        if let cuisine = recipe.cuisine, !cuisine.isEmpty {
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
                Text("\(recipes.count) \(store.language == .chinese ? "道" : "dishes")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
