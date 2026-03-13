import SwiftUI

struct SplashView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack(spacing: 12) {
                Image(systemName: "fork.knife")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.accentColor)
                    .scaleEffect(animate ? 1.0 : 0.7)
                    .opacity(animate ? 1.0 : 0.2)
                Text("Meal Plan")
                    .font(.headline)
                    .opacity(animate ? 1.0 : 0.2)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                animate = true
            }
        }
    }
}
