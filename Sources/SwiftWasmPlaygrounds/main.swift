import TokamakShim

struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("SwiftWasmPlaygrounds App") {
            ContentView()
        }
    }
}

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

// @main attribute is not supported in SwiftPM apps.
// See https://bugs.swift.org/browse/SR-12683 for more details.
TokamakApp.main()
