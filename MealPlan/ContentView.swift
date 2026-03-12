import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WeeklyPlanView()
                .tabItem {
                    Label("Plan", systemImage: "calendar")
                }
            GroceryListView()
                .tabItem {
                    Label("Groceries", systemImage: "cart")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
    }
}
