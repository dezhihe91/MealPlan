import SwiftUI

@main
struct MealPlanApp: App {
    @StateObject private var store = MealPlanStore()
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                } else {
                    ContentView()
                        .environmentObject(store)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation {
                        showSplash = false
                    }
                }
            }
        }
    }
}
