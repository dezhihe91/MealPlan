import SwiftUI

struct 菜谱DetailView: View {
    let recipe: 菜谱

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.name)
                    .font(.title2)
                    .bold()

                if let nutrition = recipe.nutrition {
                    Text(nutrition)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("食材")
                        .font(.headline)
                    ForEach(recipe.ingredients) { item in
                        Text("• \(item.name) — \(item.quantity, specifier: "%.1f") \(item.unit)")
                            .font(.subheadline)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("做法")
                        .font(.headline)
                    Text(recipe.instructions)
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("菜谱")
        .navigationBarTitleDisplayMode(.inline)
    }
}
