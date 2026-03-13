import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            Form {
                Section(store.language == .chinese ? "模板" : "Template") {
                    Picker(store.language == .chinese ? "计划类型" : "Plan Style", selection: $store.selectedTemplate) {
                        ForEach(MealTemplate.allCases) { template in
                            Text(template.title(for: store.language)).tag(template)
                        }
                    }
                }

                Section(store.language == .chinese ? "买菜日" : "Grocery Days") {
                    ForEach(Weekday.allCases) { day in
                        Toggle(day.title(for: store.language), isOn: Binding(
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

                Section(store.language == .chinese ? "营养目标（可选）" : "Nutrition Goals (Optional)") {
                    Stepper(value: $store.nutritionGoals.calories, in: 0...5000, step: 50) {
                        Text(store.language == .chinese ? "热量：\(store.nutritionGoals.calories)" : "Calories: \(store.nutritionGoals.calories)")
                    }
                    Stepper(value: $store.nutritionGoals.protein, in: 0...300, step: 5) {
                        Text(store.language == .chinese ? "蛋白（g）：\(store.nutritionGoals.protein)" : "Protein (g): \(store.nutritionGoals.protein)")
                    }
                    Stepper(value: $store.nutritionGoals.carbs, in: 0...600, step: 10) {
                        Text(store.language == .chinese ? "碳水（g）：\(store.nutritionGoals.carbs)" : "Carbs (g): \(store.nutritionGoals.carbs)")
                    }
                    Stepper(value: $store.nutritionGoals.fat, in: 0...200, step: 5) {
                        Text(store.language == .chinese ? "脂肪（g）：\(store.nutritionGoals.fat)" : "Fat (g): \(store.nutritionGoals.fat)")
                    }
                }
            }
            .navigationTitle(store.language == .chinese ? "设置" : "Settings")
        }
    }
}
