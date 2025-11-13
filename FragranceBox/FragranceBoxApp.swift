import SwiftUI

@main
struct FragranceBoxApp: App {
    @ObservedObject var userService = UserService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userService)
                .preferredColorScheme(.dark)
        }
    }
}
