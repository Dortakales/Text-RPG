import SwiftUI

struct ChooseClassView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var isWildShapeMenuVisible = false
    
    var body: some View {
        VStack {
            Text("Choose your class")
                .font(.title)
                .padding()
            
            Button(action: {
                viewModel.chooseClass(.paladin)
            }) {
                Text("Paladin")
            }.foregroundColor(.pink)
            
            Button(action: {
                viewModel.chooseClass(.druid)
            }) {
                Text("Druid")
            }.foregroundColor(.green)
            
            Button(action: {
                viewModel.chooseClass(.rogue)
            }) {
                Text("Rogue")
            }.foregroundColor(.yellow)
            
            Button(action: {
                viewModel.chooseClass(.mage)
            }) {
                Text("Mage")
            }.foregroundColor(.blue)
        }

    }
}





struct ChooseClassView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GameViewModel()
        return ChooseClassView(viewModel: viewModel)
    }
}
