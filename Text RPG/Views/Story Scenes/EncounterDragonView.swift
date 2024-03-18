import SwiftUI

struct EncounterDragonView: View {
    
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            Text("You encounter a dragon. What do you do?")
                .font(.title)
                .padding()

            Button(action: {
                viewModel.fightDragon()
            }) {
                Text("Fight the dragon")
            }

            Button(action: {
                
            }) {
                Text("Run away")
            }
        }
    }
}
