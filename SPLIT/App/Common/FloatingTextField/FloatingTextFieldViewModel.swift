import Foundation

enum ValidateOnChange {
  case yes((String) -> String?)
  case no
}

enum FloatingTextFieldState {
  case empty
  case base
  case valid
  case invalid
}

class FloatingTextFieldViewModel: ObservableObject {

  // MARK: - Properties -

  @Published private(set) var state: FloatingTextFieldState
  @Published var isDisabled: Bool {
    didSet { self.state = text.isEmpty ? .empty : .base }
  }

  private(set) var text: String
  private(set) var errorMessage: String = ""
  private(set) var placeholder: String
  private(set) var validateOnChange: ValidateOnChange

  // MARK: - Lifecycle -

  init(placeholder: String = "",
       text: String = "",
       isDisabled: Bool = false,
       validateOnChange: ValidateOnChange = .no
  ) {
    self.placeholder = placeholder
    self.text = text
    self.isDisabled = isDisabled
    self.validateOnChange = validateOnChange

    self.state = text.isEmpty ? .empty : .base
  }

  // MARK: - Private -

  private func onChange(text: String) {
    self.text = text
    switch validateOnChange {
      case .yes(let validate):
        if text.isEmpty {
          state = .empty
        } else if let errorMessage = validate(text) {
          self.errorMessage = errorMessage
          state = .invalid
        } else {
          state = .valid
        }
      case .no:
        break
    }
  }

  // MARK: - Public -

  func validate(with handler: (String) -> String?) -> Bool {
    if let errorMessage = handler(text) {
      self.errorMessage = errorMessage
      state = .invalid
      return false
    } else {
      state = .valid
      return true
    }
  }
}
