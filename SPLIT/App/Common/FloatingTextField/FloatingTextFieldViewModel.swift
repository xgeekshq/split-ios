import Foundation

class FloatingTextFieldViewModel: ObservableObject {

  // MARK: - Properties -

  @Published private(set) var style: FloatingTextFieldStyle = .empty
  @Published var isDisabled: Bool {
    didSet { setupFieldStyle() }
  }

  private(set) var text: String
  private(set) var errorMessage: String = "Error"
  private(set) var placeholder: String
  private(set) var validate: ((String) -> Validated<Void, String>)?

  // MARK: - Lifecycle -

  init(placeholder: String = "",
       text: String = "",
       isDisabled: Bool = false,
       validate: ((String) -> Validated<Void, String>)? = nil) {
    self.placeholder = placeholder
    self.text = text
    self.isDisabled = isDisabled
    self.validate = validate

    setupFieldStyle()
  }

  private func setupFieldStyle() {
    switch (isDisabled, text.isEmpty) {
      case (true, true):
        style = .emptyAndDisabled
      case (true, false):
        style = .baseAndDisabled
      case (false, true):
        style = .empty
      case (false, false):
        evaluateData()
    }
  }

  private func evaluateData() {
    if let state = validate?(text) {
      switch state {
        case .valid:
          style = .valid
        case .invalid(let error):
          errorMessage = error[0]
          style = .error
      }
    } else {
      style = .base
    }
  }


  func onChange(text: String) {
    self.text = text
    setupFieldStyle()
  }
}
