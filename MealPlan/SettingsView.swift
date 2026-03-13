import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: MealPlanStore

    var body: some View {
        NavigationStack {
            Form {
                                                            }
            .navigationTitle(store.language == .chinese ? "设置" : "Settings")
        }
    }
}
