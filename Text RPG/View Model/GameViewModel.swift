import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameState: GameState = .choosingClass
    @Published var selectedClass: PlayerClass?
    @Published var player = Player()
    @Published var isShapeshiftMenuVisible = false
    @Published var isPlayerTurn: Bool = true
    @Published var timerValue: Int = 15
    @Published var EnemySpellMessage: String?
    @Published var currentEnemy: Enemy?
    @Published var dragon = Dragon()

    
    func chooseClass(_ playerClass: PlayerClass) {
        selectedClass = playerClass
        setupPlayer()
        gameState = .onBridge
        player.level = 1
    }
    var timer: Timer?

    func startCombat() {
        isPlayerTurn = true
        timerValue = 15
        player.health = 100
        player.mana = 1000

        
        currentEnemy = Dragon()

        startTimer()
    }
              
    func startPlayerTurn() {
        DispatchQueue.main.async {
            self.isPlayerTurn = true
            self.timerValue = 15
            self.startTimer()
        }
    }

    func startEnemyTurn() {
        isPlayerTurn = false
        if let enemy = currentEnemy {
            EnemySpellMessage = enemy.takeTurn(against: &player)
            checkEnemyHealth()
            
            if gameState != .gameOver && gameState != .isDragonDefeated {
                startPlayerTurn()
            }
        }
    }
    private func checkEnemyHealth() {
        if let enemy = currentEnemy, enemy.health <= 0 {
            gameState = .isDragonDefeated
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
            } else {
                timer.invalidate()
                self.endPlayerTurn()
            }
        }
    }

    private func endPlayerTurn() {
        isPlayerTurn = false
        startEnemyTurn()
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
            return
        }
        
        if let manaCost = spell.manaCost {
            guard player.mana >= manaCost else {
                return
            }
            player.mana -= manaCost
        } else if let staminaCost = spell.staminaCost {
            guard player.stamina >= staminaCost else {
                return
            }
            player.stamina -= staminaCost
        } else {
            return
        }
        
        if let damage = spell.damage, var enemy = currentEnemy {
                enemy.applyDamage(damage)
                self.currentEnemy = enemy 
            } else {
            }

            startEnemyTurn()
        }
    
    
    
    func toggleshapeShiftMenu() {
        isShapeshiftMenuVisible.toggle()
       
        
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
