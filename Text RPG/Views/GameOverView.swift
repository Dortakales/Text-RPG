import SwiftUI

struct GameOverView: View {
    
@ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.title)
                .padding()
            
            Button(action: {
                viewModel.gameState = .choosingClass
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

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView( viewModel: GameViewModel())
    }
}
