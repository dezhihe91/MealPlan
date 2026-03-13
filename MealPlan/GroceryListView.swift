import SwiftUI

struct GroceryListView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            Group {
                if let plan = store.currentPlan {
                    let trips = store.groceryTrips(for: plan)
                    List {
                        ForEach(trips) { trip in
                            Section(header: Text(store.language == .chinese ? "买菜日：\(trip.weekday.title(for: store.language))" : "Shop on \(trip.weekday.title(for: store.language))")) {
                                let grouped = Dictionary(grouping: trip.items, by: { $0.category })
                                ForEach(IngredientCategory.allCases) { category in
                                    if let items = grouped[category] {
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(category.title(for: store.language))
                                                .font(.headline)
                                            ForEach(items) { item in
                                                Text("• \(item.name) — \(item.quantity, specifier: "%.1f") \(item.unit)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    VStack(spacing: 8) {
                        Image(systemName: "cart")
                            .font(.system(size: 36))
                            .foregroundColor(.secondary)
                        Text(store.language == .chinese ? "暂无计划" : "No plan yet")
                            .font(.headline)
                        Text(store.language == .chinese ? "生成计划后查看购物清单" : "Generate a plan to see grocery lists.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 24)
                }
            }
            .navigationTitle(store.language == .chinese ? "买菜清单" : "Groceries")
        }
    }
}
