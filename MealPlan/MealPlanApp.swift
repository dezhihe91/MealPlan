import SwiftUI

@main
struct MealPlanApp: App {
    @StateObject private var store = MealPlanStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
