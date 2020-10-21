import TokamakShim

struct ContentView: View {
    @State var text = "0"
    var body: some View {
        NavigationView {    
            VStack {
                Text(text)
                HStack(alignment: .bottom) {
                    NumberPad(text: $text)
                    CalcPad()
                }
                NavigationLink(destination: Text("hello")) { Text("navigation link") }
            }
        }
    }
}

