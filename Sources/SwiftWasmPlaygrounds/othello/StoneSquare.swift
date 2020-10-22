import TokamakShim
import CombineShim

struct StoneSquare: View {
  enum Surface {
    case none
    case willPut
    case exists(Stone.Color)
  }

  let row: Int
  let column: Int
  let stone: StoneSquare.Surface
  let onPut: PassthroughSubject<(row: Int, column: Int), Never>

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .frame(width: 50, height: 50)
        .border(Color.black)
      if case .willPut = stone {
        Button(action: { onPut.send((row: row, column: column))}) { Text("x") }
      }
      if case .exists(let color) = stone {
        Stone(color: color)
      }
    }
  }
}

