import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            Form {
                Section("Template") {
                    Picker("Plan Style", selection: $store.selectedTemplate) {
                        ForEach(MealTemplate.allCases) { template in
                            Text(template.title).tag(template)
                        }
                    }
                }

                Section("Grocery Days") {
                    ForEach(Weekday.allCases) { day in
                        Toggle(day.title, isOn: Binding(
                            get: { store.groceryDays.contains(day) },
                            set: { isOn in
                                if isOn {
                                    store.groceryDays.insert(day)
                                } else {
                                    store.groceryDays.remove(day)
                                }
                            }
                        ))
                    }
                }

                Section("Nutrition Goals (Optional)") {
                    Stepper(value: $store.nutritionGoals.calories, in: 0...5000, step: 50) {
                        Text("Calories: \(store.nutritionGoals.calories)")
                    }
                    Stepper(value: $store.nutritionGoals.protein, in: 0...300, step: 5) {
                        Text("Protein (g): \(store.nutritionGoals.protein)")
                    }
                    Stepper(value: $store.nutritionGoals.carbs, in: 0...600, step: 10) {
                        Text("Carbs (g): \(store.nutritionGoals.carbs)")
                    }
                    Stepper(value: $store.nutritionGoals.fat, in: 0...200, step: 5) {
                        Text("Fat (g): \(store.nutritionGoals.fat)")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
