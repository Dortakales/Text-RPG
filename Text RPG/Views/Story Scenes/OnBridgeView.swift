import SwiftUI

struct OnBridgeView: View {
    
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            Text("You come across a bridge. What do you do?")
                .font(.title)
                .padding()

            Button(action: {
                viewModel.goOverBridge()
            }) {
                Text("Go over the bridge")
            }

            Button(action: {
                
            }) {
                Text("Go around the bridge")
            }
        }
    }
}
