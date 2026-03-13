import SwiftUI

struct WeeklyPlanView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(store.language == .chinese ? "模板" : "Template")
                        .font(.subheadline)
                    HStack {
                        ForEach(MealTemplate.allCases) { template in
                            Button(action: { store.selectedTemplate = template }) {
                                Text(template.title(for: store.language))
                                    .font(.caption)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 8)
                                    .background(store.selectedTemplate == template ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(store.language == .chinese ? "买菜日" : "Grocery Days")
                        .font(.subheadline)
                    HStack {
                        ForEach(Weekday.allCases) { day in
                            Button(action: {
                                if store.groceryDays.contains(day) {
                                    store.groceryDays.remove(day)
                                } else {
                                    store.groceryDays.insert(day)
                                }
                            }) {
                                Text(day.title(for: store.language))
                                    .font(.caption)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 8)
                                    .background(store.groceryDays.contains(day) ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                HStack(spacing: 12) {
                    Button(store.language == .chinese ? "生成计划" : "Generate Plan") {
                        store.generatePlan()
                    }
                    .buttonStyle(.borderedProminent)

                    Button(store.language == .chinese ? "重复上周" : "Repeat Last Week") {
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
                                        let summaryLabel = mealSummaryLabel(for: recipes)
                                        let countLabel = store.language == .chinese ? "\(recipes.count) 道" : "\(recipes.count) dishes"
                                        NavigationLink(destination: MealDetailView(mealType: mealType, recipes: recipes)) {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(mealType.title(for: store.language))
                                                        .font(.subheadline)
                                                    Text(summaryLabel)
                                                        .font(.footnote)
                                                        .foregroundColor(.secondary)
                                                }
                                                Spacer()
                                                Text(countLabel)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
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
                        Text(store.language == .chinese ? "暂无计划" : "No plan yet")
                            .font(.headline)
                        Text(store.language == .chinese ? "点击生成计划开始使用" : "Generate a weekly plan to get started.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 24)
                }
            }
            .padding(.horizontal)
            .navigationTitle(store.language == .chinese ? "本周计划" : "Weekly Plan")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: toggleLanguage) {
                        Text(store.language == .chinese ? "EN" : "中文")
                    }
                }
            }
        }
    }

    private func mealSummaryLabel(for recipes: [Recipe]) -> String {
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

    private func toggleLanguage() {
        store.language = store.language == .chinese ? .english : .chinese
    }
}
