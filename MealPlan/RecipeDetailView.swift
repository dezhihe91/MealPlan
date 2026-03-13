import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject var store: MealPlanStore
    let recipe: Recipe

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
                                Text("• \(item.name) — \(item.quantity, specifier: "%.1f") \(item.unit)")
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
                        Text("\(index + 1). \(step)")
                            .font(.body)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(store.language == .chinese ? "菜谱" : "Recipe")
        .navigationBarTitleDisplayMode(.inline)
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
