import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            Form {
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

                            }
            .navigationTitle(store.language == .chinese ? "设置" : "Settings")
        }
    }
}
