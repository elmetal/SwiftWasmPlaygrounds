enum TTTMark {
  case none
  case o
  case x

  var string: String {
    switch self {
      case .o:
        return "o"
      case .x:
        return "x"
      case .none:
        return "-"
    }
  }
}

