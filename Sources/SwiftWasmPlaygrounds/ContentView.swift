import TokamakShim

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
              .padding()
            Spacer()
            Text("オセロ")
              .padding(4)

            OthelloBoard()
            Spacer()
            HTML("a", ["href":"https://github.com/elmetal/SwiftWasmPlaygrounds"]) {
              Text("repository")
                .foregroundColor(.blue)
                .padding()
            }
        }
    }
}

