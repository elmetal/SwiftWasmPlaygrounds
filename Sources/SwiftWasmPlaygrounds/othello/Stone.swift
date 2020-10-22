import TokamakShim

struct Stone: View {
  enum Color {
    case black
    case white

    var fill: String{
      switch self {
      case .black:
        return "black"
      case .white:
        return "white"
      }
    }

    var stroke: String{
      switch self {
      case .black:
        return "white"
      case .white:
        return "black"
      }
    }
  }

  var color: Stone.Color

  init(color: Stone.Color) {
    self.color = color
  }

  var body: some View {
    HTML("svg", ["width": "50", "height": "50"]) {
      HTML("circle", [
        "cx": "25", "cy": "25", "r": "20",
        "stroke": "\(color.stroke)", "stroke-width": "2", "fill": "\(color.fill)",
      ])
    }
  }

}

