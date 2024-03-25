
import SwiftUI

@main
struct TextRpgApp: App {
    @StateObject var gameViewModel = GameViewModel()


    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
