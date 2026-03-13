import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var store: MealPlanStore
    let mealType: MealType
    let recipes: [Recipe]

    var body: some View {
        List {
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
    }
}
