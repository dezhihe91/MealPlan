import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        TabView {
            WeeklyPlanView()
                .tabItem {
                    Label(store.language == .chinese ? "计划" : "Plan", systemImage: "calendar")
                }
            GroceryListView()
                .tabItem {
                    Label(store.language == .chinese ? "买菜" : "Groceries", systemImage: "cart")
                }
            SettingsView()
                .tabItem {
                    Label(store.language == .chinese ? "设置" : "Settings", systemImage: "slider.horizontal.3")
                }
        }
    }
}
