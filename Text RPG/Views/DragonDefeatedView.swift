import SwiftUI

struct DragonDefeatedView: View {
    @Binding var gameState: GameState
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            Text("Dragon Defeated")
                .font(.title)
                .padding()
            
            Button(action: {
                gameState = .choosingClass
            }) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

