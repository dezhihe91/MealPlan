import Foundation
import UserNotifications

final class ReminderManager {
    private let center = UNUserNotificationCenter.current()

    func requestAuthorization(completion: ((Bool) -> Void)? = nil) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async { completion?(granted) }
        }
    }

    func scheduleGroceryReminders(weekdays: Set<Weekday>, time: Date) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)

        for day in weekdays {
            let content = UNMutableNotificationContent()
            content.title = "买菜提醒"
            content.body = "今天是买菜日，记得查看清单。"
            content.sound = .default

            var components = DateComponents()
            components.weekday = day.rawValue
            components.hour = hour
            components.minute = minute

            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: "grocery-reminder-\(day.rawValue)", content: content, trigger: trigger)
            center.add(request)
        }
    }

    func cancelGroceryReminders() {
        let ids = Weekday.allCases.map { "grocery-reminder-\($0.rawValue)" }
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
}
