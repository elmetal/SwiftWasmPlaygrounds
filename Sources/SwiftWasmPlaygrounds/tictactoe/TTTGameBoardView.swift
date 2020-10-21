import TokamakShim
import CombineShim

struct TTTGameBoardView: View {
  @ObservedObject var boardState = TTTGameBoardState()
  var body: some View {
    VStack {
      Text("\(boardState.current.string)の番")
      HStack {
        Button(action: { boardState.onTap.send(0) }) { Text(boardState.board[0].string) }
        Button(action: { boardState.onTap.send(1) }) { Text(boardState.board[1].string) }
        Button(action: { boardState.onTap.send(2) }) { Text(boardState.board[2].string) }
      }

      HStack {
        Button(action: { boardState.onTap.send(3) }) { Text(boardState.board[3].string) }
        Button(action: { boardState.onTap.send(4) }) { Text(boardState.board[4].string) }
        Button(action: { boardState.onTap.send(5) }) { Text(boardState.board[5].string) }
      }

      HStack {
        Button(action: { boardState.onTap.send(6) }) { Text(boardState.board[6].string) }
        Button(action: { boardState.onTap.send(7) }) { Text(boardState.board[7].string) }
        Button(action: { boardState.onTap.send(8) }) { Text(boardState.board[8].string) }
      }
    }
    Button(action: { boardState.reset() }) { Text("リセット") }
  }
}

