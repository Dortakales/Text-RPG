
import SwiftUI

struct CombatView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            HealthBar(value: Double(viewModel.player.health), maxValue: 10.0)
            HealthBar(value: Double(viewModel.dragon.health), maxValue: 30.0)
            
            if let playerClass = viewModel.selectedClass {
                if playerClass == .druid && viewModel.player.form == .tiger {
                    StaminaBar(value: Double(viewModel.player.stamina), maxValue: 10.0)
                } else if playerClass == .rogue {
                    StaminaBar(value: Double(viewModel.player.stamina), maxValue: 10.0)
                } else {
                    ManaBar(value: Double(viewModel.player.mana), maxValue: 10.0)
                }
            }
            
            Text("Combat Scene")
                .font(.title)
                .padding()
            
            Text("Player Health: \(viewModel.player.health)")
            Text("Dragon Health: \(viewModel.dragon.health)")
            
            if viewModel.isPlayerTurn {
                Text("Player's Turn - \(viewModel.timerValue)s")
                

                ForEach(viewModel.player.spellbook, id: \.self) { spell in
                    Button(action: {
                        
                        viewModel.castSpell(spell)
                    }) {
                        Text(spell.name)
                    }
                }
                
                if viewModel.selectedClass == .druid {
                    Button(action: {
                        viewModel.toggleWildShapeMenu()
                    }) {
                        Text("Wild Shape")
                    }
                }
            } else {
                Text("Dragon's Turn")
            }
            if let dragonSpellMessage = viewModel.dragonSpellMessage {
                Text(dragonSpellMessage)
                    .padding()
                    .onAppear {
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            viewModel.dragonSpellMessage = nil
                        }
                    }
            }
            
        }
        .onAppear {
            viewModel.startCombat()
        }
        .onChange(of: viewModel.isPlayerTurn) { isPlayerTurn in
            if isPlayerTurn {
                viewModel.startPlayerTurn()
            }
        }.onChange(of: viewModel.player.health) { _ in
            viewModel.checkPlayerHealth()
        }
        .sheet(isPresented: $viewModel.isWildShapeMenuVisible) {
            WildShapeSheet(viewModel: viewModel)
                .presentationDetents ([.height (200),.medium, .medium])
                .presentationDragIndicator(.automatic)
        }
    }
}
