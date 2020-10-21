import TokamakShim
import CombineShim

struct TTTGameBoard: View {
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

class TTTGameBoardState: ObservableObject {
  private let players: [TTTMark]  = [.o, .x]
  private(set) var current: TTTMark = .o
  @Published private(set) var board: [TTTMark] = [.none, .none, .none, .none, .none, .none, .none, .none, .none]

  let onTap = PassthroughSubject<Int, Never>()
  private var cancellables = Set<AnyCancellable>()

  init() {
    onTap.sink { [weak self] index in 
      guard let self = self else { return }
      if self.board[index] == .none {
        self.board[index] = self.current
        self.current = self.players.filter { [weak self] in $0 != self?.current }.first!
      }
    }
    .store(in: &cancellables)
  }

  func reset() {
    self.current = .o
    self.board = [.none, .none, .none, .none, .none, .none, .none, .none, .none]
  }
}

enum TTTGameState {
  case playing
  case end
}
enum TTTGameResult {
  case owin
  case xwin
  case draw
}
