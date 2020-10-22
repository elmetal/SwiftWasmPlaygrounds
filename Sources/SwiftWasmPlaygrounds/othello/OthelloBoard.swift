import TokamakShim
import CombineShim

struct OthelloBoard: View {
  @State var stone:StoneSquare.Surface = .willPut
  @ObservedObject var state = OthelloGameState()
  private let rows = 8
  private let columns = 8

  var body: some View {
    VStack {
      HStack {
        Stone(color: state.current)
        Text("の番")
      }
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<columns, id: \.self) { column in
            StoneSquare(row: row, column: column, stone: state.board[row][column], onPut: state.onPut)
          }
        }
      }
    }
  }
}

class OthelloGameState: ObservableObject {
  private let players: [Stone.Color] = [.black, .white]

  private let rows = 8
  private let columns = 8

  @Published private(set) var current: Stone.Color = .black
  @Published var board: [[StoneSquare.Surface]] = Array(repeating: Array(repeating: .willPut, count: 8),
                                                        count: 8) 
                                                        

  let onPut = PassthroughSubject<(row: Int, column: Int), Never>()
  private var cancellables = Set<AnyCancellable>()

  init() {
    setup()
    onPut.sink { [weak self] (row, column) in 
      guard let self = self else { return }
      self.put(row: row, column: column)
      self.current = [.black, .white].filter { [weak self] in $0 != self?.current }.first!
      self.suggestWillPut()
    }
    .store(in: &cancellables)
  }

  private func setup() {
    board[3][3] = .exists(.black)
    board[3][4] = .exists(.white)
    board[4][3] = .exists(.white)
    board[4][4] = .exists(.black)
    suggestWillPut()
  }

  private func put(row: Int, column: Int) {
    self.board[row][column] = .exists(self.current)
  
    func up() {
      for r in (0...row-1).reversed() {
        switch board[r][column] {
        case .none, .willPut:
          return
        case .exists(let color):
          if color == self.current {
            for n in r...row {
              board[n][column] = .exists(self.current)
            } 
          }
        }
      }
    }

    func upLeft() {
      for i in (1...min(row, column)) {
        switch board[row-i][column-i] {
        case .none, .willPut:
          return
        case .exists(let color):
          if color == self.current {
            for n in 0...i {
              board[row-n][column-n] = .exists(self.current)
            } 
          }
        }
      }
    }

    func upRight() {
      for i in (1...min(row, 7-column)) {
        switch board[row-i][column+i] {
        case .none, .willPut:
          return
        case .exists(let color):
          if color == self.current {
            for n in 0...i {
              board[row-n][column+n] = .exists(self.current)
            } 
          }
        }
      }
    }

    if row > 0 {
      up()
      if column > 0 {
        upLeft()
      }
      if column < 7 {
        upRight()
      }
    } 

    func down() {
      for r in (row+1...7) {
        switch board[r][column] {
        case .none, .willPut:
          return
        case .exists(let color):
          if color == self.current {
            for n in row...r {
              board[n][column] = .exists(self.current)
            } 
          }
        }
      }
    }

    func downLeft() {
       for i in (1...min(7-row, column)) {
        switch board[row+i][column-i] {
        case .none, .willPut:
          return
        case .exists(let color):
          if color == self.current {
            for n in 0...i {
              board[row+n][column-n] = .exists(self.current)
            } 
          }
        }
      }
    }

    func downRight() {
       for i in (1...min(7-row, 7-column)) {
        switch board[row+i][column+i] {
        case .none, .willPut:
          return
        case .exists(let color):
          if color == self.current {
            for n in 0...i {
              board[row+n][column+n] = .exists(self.current)
            } 
          }
        }
      }
   
    }

    if row < 7 {
      down()

      if column > 0 {
        downLeft()
      }

      if column < 7 {
        downRight()
      }
    }

    func left() {
      for c in (0...column-1).reversed() {
        switch board[row][c] {
        case .none, .willPut:
          return
        case .exists(let color):  
          if color == self.current {
            for n in c...column {
              board[row][n] = .exists(self.current)
            }
          }
        }
      }
    }

    if column > 0 {
      left()
    }

    func right() {
      for c in (column+1...7) {
        switch board[row][c] {
        case .none, .willPut:
          return
        case .exists(let color):  
          if color == self.current {
            for n in column...c {
              board[row][n] = .exists(self.current)
            }
          }
        }
      }
    }

    if column < 7 {
      right()
    }

  }

  private func suggestWillPut() {
    for row in 0...7 {
      for column in 0...7 {
        var ambiguous = true
        if row > 0 {
           switch board[row-1][column] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }
         }
        }

        if ambiguous, row < 7 {
           switch board[row+1][column] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }

          }
        }

        if ambiguous, column > 0 {
           switch board[row][column-1] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }
          }
        }

        if ambiguous, column < 7 {
           switch board[row][column+1] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }
          }
        }

        if ambiguous, row > 0, column > 0 {
           switch board[row-1][column-1] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }
          }
        }

        if ambiguous, row < 7, column > 0 {
           switch board[row+1][column-1] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }
          }
        }

        if ambiguous, row > 0, column < 7 {
           switch board[row-1][column+1] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }
          }
        }

        if ambiguous, row < 7, column < 7 {
           switch board[row+1][column+1] {
           case .none, .willPut:
             break
           case .exists(let color):
             ambiguous = false
             if case .none = board[row][column] {
               board[row][column] = .willPut
             }
             if case .willPut = board[row][column] {
               if color == current {
                 board[row][column] = .none
               }
             }
          }
        }

        if ambiguous {
           board[row][column] = .none
        }
      }
    }
  
  }



}

