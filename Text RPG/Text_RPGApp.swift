
import SwiftUI

@main
struct TextRpgApp: App {
    var viewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
