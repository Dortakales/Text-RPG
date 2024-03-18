import SwiftUI
import Combine


class GameViewModel: ObservableObject {
    @Published var gameState: GameState = .choosingClass
    @Published var selectedClass: PlayerClass?
    @Published var player = Player()
    @Published var dragon = Dragon()
    @Published var isWildShapeMenuVisible = false
    @Published var isPlayerTurn: Bool = true
    @Published var timerValue: Int = 15
    @Published var dragonSpellMessage: String?
    
    
    
    var timer: Timer?
    
    func startCombat() {
        
        isPlayerTurn = true
        timerValue = 15
        player.health = 100
        player.mana = 1000
        dragon.health = 30
        
        startTimer()
    }
    
    func startPlayerTurn() {
        isPlayerTurn = true
        timerValue = 15
        startTimer()
        
    }
    func startDragonTurn() {
        isPlayerTurn = false
        dragonTurn()
    }
    
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            guard self.timerValue > 0 else {
                self.endPlayerTurn()
                return
            }
            self.timerValue -= 1
        }
    }

    
    private func endPlayerTurn() {
        isPlayerTurn = false
        startDragonTurn()
    }
    func dragonTurn() {
       
        let probabilities: [AttackSpell: Double] = [
            dragon.attackspellbook[0]: 0.4,
            dragon.attackspellbook[1]: 0.6
        ]
        
        let randomSpell = dragonWeightedRandom(probabilities: probabilities)
        
        if let damage = randomSpell.damage {
            player.takeDamage(amount: damage)
        }
        
        dragonSpellMessage = "Dragon used \(randomSpell.name)"
        startPlayerTurn()
        
        if dragon.health <= 0 {
            gameState = .isDragonDefeated
               }
        
        
    }

    
    func dragonWeightedRandom<T>(probabilities: [T: Double]) -> T {
        let totalWeight = probabilities.values.reduce(0, +)
        let randomNumber = Double.random(in: 0..<totalWeight)
        var cumulativeWeight = 0.0
        
        for (element, weight) in probabilities {
            cumulativeWeight += weight
            if randomNumber < cumulativeWeight {
                return element
            }
        }
        
        fatalError("Invalid probabilities")
    }
    
    
    
    
    
    func chooseClass(_ playerClass: PlayerClass) {
        selectedClass = playerClass
        setupPlayer()
        gameState = .onBridge
        player.level = 1
    }
    
    private func setupPlayer() {
        switch selectedClass {
        case .druid:
            player.spellbook = [
                Spell(name: "Moonbeam", damage: 3, manaCost: 2,staminaCost: nil)
            ]
        case .paladin:
            player.spellbook = [
                Spell(name: "Hammer of Justice", damage: 2, manaCost: 3,staminaCost: nil),
                Spell(name: "Shield Bash", damage: 3, manaCost: 2,staminaCost: nil)
            ]
        case .rogue:
            player.spellbook = [
                Spell(name: "Fan of Knives", damage: 2, manaCost: nil, staminaCost: 1),
                Spell(name: "Stealth", damage: nil,manaCost: nil, staminaCost: nil)
            ]
        case .mage:
            player.spellbook = [
                Spell(name: "Fireball", damage: 3, manaCost: 4,staminaCost: nil),
                Spell(name: "Blizzard", damage: 4, manaCost: 5,staminaCost: nil)
            ]
        case .none:
            break
        }
    }
    
    
    func goOverBridge() {
        gameState = .encounterDragon
    }
    
    func fightDragon() {
        gameState = .inCombat
        dragon = Dragon()
    }
    
    func castSpell(_ spell: Spell) {
        
        guard isPlayerTurn else {
            print("It's not the player's turn.")
            return
        }
        
        if let manaCost = spell.manaCost {
            guard player.mana >= manaCost else {
                print("Not enough mana to cast \(spell.name).")
                return
            }
            player.mana -= manaCost
        } else if let staminaCost = spell.staminaCost {
            guard player.stamina >= staminaCost else {
                print("Not enough stamina to cast \(spell.name).")
                return
            }
            player.stamina -= staminaCost
        } else {
            print("Spell \(spell.name) does not have a mana cost or stamina cost.")
            return
        }
        
        if let damage = spell.damage {
            dragon.health -= damage
        } else {
            print("Spell \(spell.name) does not have damage.")
        }
        
        print("\(spell.name) casted successfully.")
        
        
        startDragonTurn()
    }
    
    
    
    func toggleWildShapeMenu() {
        isWildShapeMenuVisible.toggle()
        print("Wild Shape menu visibility toggled: \(isWildShapeMenuVisible)")
        
    }
    
    
    func selectTigerForm() {
        player.form = .tiger
        player.updateSpellbookForForm()
    }
    
    func checkPlayerHealth() {
        if player.health <= 0 {
            gameState = .gameOver
        }
    }
}
