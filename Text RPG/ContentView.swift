import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if viewModel.gameState == .choosingClass {
                                        ChooseClassView(viewModel: viewModel)
                                    } else if viewModel.gameState == .onBridge {
                                        OnBridgeView(viewModel: viewModel)
                                    } else if viewModel.gameState == .encounterDragon {
                                        EncounterDragonView(viewModel: viewModel)
                                    } else if viewModel.gameState == .inCombat {
                                        CombatView(viewModel: viewModel)
                                    } else if viewModel.gameState == .gameOver {
                                        GameOverView(viewModel: viewModel)
                                    } else if viewModel.gameState == .isDragonDefeated {
                                        DragonDefeatedView(gameState: $viewModel.gameState, viewModel: viewModel)
                                    }

              
                    Spacer()
                }
                .navigationBarHidden(true)
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Level: \(viewModel.player.level)")
                            .font(.caption)
                            .padding(16)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GameViewModel()
        return ContentView(viewModel: viewModel)
    }
}
