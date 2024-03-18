import Foundation



struct Dragon {
    var name: String = "Dragon"
    var health: Int = 30
    var attackspellbook: [AttackSpell] = [
            AttackSpell(name: "Breath of Fire", damage: 5, manaCost: nil, staminaCost: nil),
            AttackSpell(name: "Tail Swipe", damage: 3, manaCost: nil, staminaCost: nil)
        ]
}


struct AttackSpell: Hashable {
    let name: String
    let damage: Int?
    let manaCost: Int?
    let staminaCost: Int?
    
}
