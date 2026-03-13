import SwiftUI

struct WeeklyPlanView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Button("Generate Plan") {
                        store.generatePlan()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Repeat Last Week") {
                        store.generatePlan(repeatLastWeek: true)
                    }
                    .buttonStyle(.bordered)
                }

                if let plan = store.currentPlan {
                    List {
                        ForEach(plan.days) { day in
                            Section(header: Text(day.date.formatted(date: .abbreviated, time: .omitted))) {
                                ForEach(MealType.allCases) { mealType in
                                    if let recipes = day.meals[mealType] {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(mealType.title)
                                                .font(.headline)
                                            ForEach(recipes) { recipe in
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(recipe.name)
                                                        .font(.subheadline)
                                                        .foregroundColor(.secondary)
                                                    Text(recipe.instructions)
                                                        .font(.footnote)
                                                        .foregroundColor(.secondary)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    VStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .font(.system(size: 36))
                            .foregroundColor(.secondary)
                        Text("No plan yet")
                            .font(.headline)
                        Text("Generate a weekly plan to get started.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 24)
                }
            }
            .padding(.horizontal)
            .navigationTitle("Weekly Plan")
        }
    }
}
