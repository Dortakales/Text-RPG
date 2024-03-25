struct Dragon: Enemy {
    var name: String = "Dragon"
    var health: Int = 30
    var enemySpellBook: [EnemySpell] = [
        EnemySpell(name: "Breath of Fire", damage: 5, manaCost: nil, staminaCost: nil),
        EnemySpell(name: "Tail Swipe", damage: 3, manaCost: nil, staminaCost: nil)
    ]

    
    func takeTurn(against player: inout Player) -> String {
            let probabilities: [EnemySpell: Double] = [
                self.enemySpellBook[0]: 0.4,
                self.enemySpellBook[1]: 0.6
            ]

            let randomSpell = dragonWeightedRandom(probabilities: probabilities)
            if let damage = randomSpell.damage {
                player.takeDamage(amount: damage)
            }
            return "Dragon used \(randomSpell.name)"
        }

   private func dragonWeightedRandom<T>(probabilities: [T: Double]) -> T {
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
    mutating func applyDamage(_ damage: Int) {
         health -= damage
     }
    
}



