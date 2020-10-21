import TokamakShim

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
