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
                                    if let recipe = day.meals[mealType] {
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(mealType.title)
                                                .font(.headline)
                                            Text(recipe.name)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    ContentUnavailableView("No plan yet", systemImage: "calendar", description: Text("Generate a weekly plan to get started."))
                }
            }
            .padding(.horizontal)
            .navigationTitle("Weekly Plan")
        }
    }
}
