import SwiftUI

struct WeeklyPlanView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker(store.language == .chinese ? "模板" : "Template", selection: $store.selectedTemplate) {
                    ForEach(MealTemplate.allCases) { template in
                        Text(template.title(for: store.language)).tag(template)
                    }
                }
                .pickerStyle(.menu)

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

    private func toggleLanguage() {
        store.language = store.language == .chinese ? .english : .chinese
    }
}
