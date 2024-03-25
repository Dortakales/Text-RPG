protocol Enemy {
    var name: String { get }
    var health: Int { get set }
    var enemySpellBook: [EnemySpell] { get }
    
    
    func takeTurn(against player: inout Player) -> String
    
    mutating func applyDamage(_ damage: Int)

    
}

struct EnemySpell: Hashable {
    let name: String
    let damage: Int?
    let manaCost: Int?
    let staminaCost: Int?
    
}
