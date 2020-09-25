import TokamakShim

struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("Tokamak App") {
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

struct CalcPad: View {
    var body: some View {
        VStack {
            Button(action: {}) { Text("÷") }
            Button(action: {}) { Text("×") }
            Button(action: {}) { Text("-") }
            Button(action: {}) { Text("+") }
            Button(action: {}) { Text("=") }
        }
    }
}

// @main attribute is not supported in SwiftPM apps.
// See https://bugs.swift.org/browse/SR-12683 for more details.
TokamakApp.main()
