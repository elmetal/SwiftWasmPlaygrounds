import TokamakShim

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
              .padding()
            Spacer()
            Text("oxゲーム")
              .padding(4)
            TTTGameBoardView()
            Spacer()
            HTML("a", ["href":"https://github.com/elmetal/SwiftWasmPlaygrounds"]) {
              Text("repository")
                .foregroundColor(.blue)
                .padding()
            }
        }
    }
}

