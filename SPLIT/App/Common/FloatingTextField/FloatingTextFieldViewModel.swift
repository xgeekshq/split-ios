import Foundation

enum FloatingTextFieldState {
  case 
}

class FloatingTextFieldViewModel: ObservableObject {

  // MARK: - Properties -

  @Published var text: String = ""
  var placeholder: String


  // MARK: - Lifecycle -

  init(placeholder: String = "", text: String = "") {
    self.placeholder = placeholder
    self.text = text
  }
}
