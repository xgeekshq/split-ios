import Foundation

enum FloatingTextFieldState {
  case initial
  case valid
  case error
  case disabled
}

class FloatingTextFieldViewModel: ObservableObject {

  // MARK: - Properties -

  @Published var text: String = ""
  var placeholder: String
  var state: FloatingTextFieldState

  // MARK: - Lifecycle -

  init(placeholder: String = "", text: String = "", state: FloatingTextFieldState = .initial) {
    self.placeholder = placeholder
    self.state = state
    self.text = text
  }
}
