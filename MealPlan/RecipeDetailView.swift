import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.name)
                    .font(.title2)
                    .bold()

                if recipe.prepMinutes != nil || recipe.cookMinutes != nil {
                    let prep = recipe.prepMinutes ?? 0
                    let cook = recipe.cookMinutes ?? 0
                    let total = prep + cook
                    Text("用时：准备 \(prep) 分钟 · 烹饪 \(cook) 分钟 · 合计 \(total) 分钟")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let nutrition = recipe.nutrition {
                    Text(nutrition)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("食材准备")
                        .font(.headline)
                    let grouped = Dictionary(grouping: recipe.ingredients, by: { $0.category })
                    ForEach(IngredientCategory.allCases) { category in
                        if let items = grouped[category] {
                            Text(category.title)
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
                    Text("详细步骤")
                        .font(.headline)
                    let steps = stepsFromInstructions(recipe.instructions)
                    ForEach(Array(steps.enumerated()), id: \.(offset)) { index, step in
                        Text("\(index + 1). \(step)")
                            .font(.body)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("菜谱")
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
