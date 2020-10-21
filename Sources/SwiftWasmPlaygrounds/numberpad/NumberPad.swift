import TokamakShim

struct NumberPad: View {
    @Binding var text: String
    @State var culcBuffer = ""
    
    var body: some View {
        VStack {
            HStack {
                NumberKey(text: $text, number: 7)
                NumberKey(text: $text, number: 8)
                NumberKey(text: $text, number: 9)
            }
            HStack {
                NumberKey(text: $text, number: 4)
                NumberKey(text: $text, number: 5)
                NumberKey(text: $text, number: 6)
            }
            HStack {
                NumberKey(text: $text, number: 1)
                NumberKey(text: $text, number: 2)
                NumberKey(text: $text, number: 3)
            }
            NumberKey(text: $text, number: 0)
        }
    }
}

struct NumberKey: View {
    @Binding var text: String
    let number: Int
    var body: some View {
        Button(action: { text += "\(number)" }) { Text("\(number)") }
    }            
}
