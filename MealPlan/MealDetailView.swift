import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var store: MealPlanStore
    let mealType: MealType
    let recipes: [Recipe]

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
                Text("\(recipes.count) \(store.language == .chinese ? "道" : "dishes")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
