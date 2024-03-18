import SwiftUI

struct StaminaBar: View {
    var value: Double
    var maxValue: Double
    var barWidth: CGFloat = 200
    var barHeight: CGFloat = 20
    var barColor: Color = .yellow
    var borderColor: Color = .black
    
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

struct StaminaBar_Previews: PreviewProvider {
    static var previews: some View {
        StaminaBar(value: 75, maxValue: 100)
            .padding()
    }
}
