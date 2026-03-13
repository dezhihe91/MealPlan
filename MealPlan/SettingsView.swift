import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: MealPlanStore
    private let reminder = ReminderManager()

    var body: some View {
        NavigationStack {
            Form {
                Section(store.language == .chinese ? "买菜提醒" : "Grocery Reminder") {
                    Toggle(store.language == .chinese ? "开启提醒" : "Enable Reminder", isOn: $store.reminderEnabled)
                    DatePicker(store.language == .chinese ? "提醒时间" : "Time", selection: $store.reminderTime, displayedComponents: .hourAndMinute)
                }
            }
            .navigationTitle(store.language == .chinese ? "设置" : "Settings")
            .onChange(of: store.reminderEnabled) { _, enabled in
                if enabled {
                    reminder.requestAuthorization { granted in
                        if granted {
                            reminder.scheduleGroceryReminders(weekdays: store.groceryDays, time: store.reminderTime)
                        }
                    }
                } else {
                    reminder.cancelGroceryReminders()
                }
            }
            .onChange(of: store.reminderTime) { _, _ in
                if store.reminderEnabled {
                    reminder.scheduleGroceryReminders(weekdays: store.groceryDays, time: store.reminderTime)
                }
            }
            .onChange(of: store.groceryDays) { _, _ in
                if store.reminderEnabled {
                    reminder.scheduleGroceryReminders(weekdays: store.groceryDays, time: store.reminderTime)
                }
            }
        }
    }
}
