import SwiftUI

struct ShapeShiftMenu: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            Text("Select Form")
                .font(.title)
                .padding()
            
            Button(action: {
                viewModel.selectTigerForm()
            }) {
                Text("Tiger Form")
            }
        }
    }
}
