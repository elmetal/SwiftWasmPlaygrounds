import TokamakShim
import CombineShim

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

