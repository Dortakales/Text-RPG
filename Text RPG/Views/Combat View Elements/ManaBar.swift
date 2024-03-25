import SwiftUI

struct ManaBar: View {
    var value: Double
    var maxValue: Double
    var barWidth: CGFloat = 200
    var barHeight: CGFloat = 20
    var barColor: Color = .blue
    var borderColor: Color = .black
    
    init(value: Double, maxValue: Double) {
        self.value = value
        self.maxValue = maxValue
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray)
                .frame(width: barWidth, height: barHeight)
                .cornerRadius(5)
            
            
            Rectangle()
                .fill(barColor)
                .frame(width: CGFloat(value / maxValue) * barWidth, height: barHeight)
                .cornerRadius(5)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(borderColor, lineWidth: 1)
        )
    }
    
}

struct ManaBar_Previews: PreviewProvider {
    static var previews: some View {
        ManaBar(value: 50, maxValue: 100)
            .padding()
    }
}
