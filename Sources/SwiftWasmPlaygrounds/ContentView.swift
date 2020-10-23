import TokamakShim

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
              .padding()
            Spacer()
            Text("オセロ")
              .font(.title2)
              .padding(4)

            OthelloBoard()
              .padding()
            Spacer()
            HTML("a", ["href":"https://github.com/elmetal/SwiftWasmPlaygrounds"]) {
              Text("repository")
                .foregroundColor(.blue)
                .padding()
            }
        }
    }
}

