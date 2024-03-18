import SwiftUI


struct Player {
    var health: Int = 1000
    var mana: Int = 10
    var stamina: Int = 10
    var spellbook: [Spell] = []
    var inventory: [String] = []
    var level: Int = 1
    var form: PlayerForm = .normal
    var experience: Int = 0
    
    
    mutating func updateSpellbookForForm() {
           switch form {
           case .normal:
               spellbook = [
                   Spell(name: "Moonbeam", damage: 3,manaCost: 2,staminaCost: nil),
               ]
           case .tiger:
               spellbook = [
                   Spell(name: "Scratch", damage: 2,manaCost: nil,staminaCost: 2),
                   Spell(name: "Roar", damage: 1,manaCost: nil, staminaCost: nil)
                
               ]
           }
       }
    
    mutating func takeDamage(amount: Int) {
         health -= amount
         health = max(0, health)
     
 }
    
}

enum PlayerClass: String {
    case druid = "Druid"
    case paladin = "Paladin"
    case rogue = "Rogue"
    case mage = "Mage"
    
  
}


struct Spell: Hashable {
    let name: String
    let damage: Int?
    let manaCost: Int?
    let staminaCost: Int?
    
}
  
enum PlayerForm {
    case normal
    case tiger
}


enum GameState {
    case choosingClass
    case onBridge
    case encounterDragon
    case inCombat
    case gameOver
    case isDragonDefeated

}

struct EnemySpell: Hashable {
    let name: String
    let damage: Int?
    let manaCost: Int?
    let staminaCost: Int?
    
}
