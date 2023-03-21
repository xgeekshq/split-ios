import SwiftUI
import Combine

struct FloatingTextField: View {

  // MARK: - Properties -

  @ObservedObject var viewModel: FloatingTextFieldViewModel
  @State var text: String

  init(viewModel: FloatingTextFieldViewModel) {
    self.viewModel = viewModel
    self.text = viewModel.text
  }

  public var body: some View {
    ZStack {
      placeholderLabel
      floatingTextField
    }
    .background(viewModel.style.backgroundColor)
    .animation(.easeIn(duration: 0.1), value: viewModel.style)
    .onChange(of: text) { viewModel.onChange(text: $0) }
  }

  var placeholderLabel: some View {
    HStack {
      Text(viewModel.placeholder)
        .font(viewModel.style.placeholderFont)
        .foregroundColor(viewModel.style.placeholderColor)
        .offset(viewModel.style.placeholderOffset)
        .padding()
        .transition(.slide)
        .transition(.scale)
      Spacer()
    }
  }

  var floatingTextField: some View {
    TextField("", text: $text)
      .textFieldStyle(FloatingTextFieldStyler(style: viewModel.style))
      .disabled(viewModel.style == .baseAndDisabled || viewModel.style == .emptyAndDisabled)
  }

  private struct FloatingTextFieldStyler: TextFieldStyle {
    var style: FloatingTextFieldStyle

    func _body(configuration field: TextField<_Label>) -> some View {
      return field
        .offset(style.textOffset)
        .font(style.textfieldFont)
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: style.borderCornerRadius)
            .stroke(style.shadowColor, style: StrokeStyle(lineWidth: style.shadowLineWidth))
        )
        .overlay(
          RoundedRectangle(cornerRadius: style.borderCornerRadius)
            .stroke(style.borderColor, style: StrokeStyle(lineWidth: style.borderLineWidth))
            .padding(1)
        )
    }
  }
}

struct FloatingTextField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      let validated: (String) -> Validated<Void,String> = { text in
        if text.contains("@") { return .valid(())}

        return .invalid([""])
      }

      let emptyVM = FloatingTextFieldViewModel(placeholder: "Empty", validate: validated)
      let emptyAndDisabledVM = FloatingTextFieldViewModel(placeholder: "Empty&Disabled", isDisabled: true, validate: validated)
      let baseVM = FloatingTextFieldViewModel(placeholder: "Base", text: "banana")
      let baseAndDisabledVM = FloatingTextFieldViewModel(placeholder: "Base&Disabled", text: "banana", isDisabled: true, validate: validated)
      let validVM = FloatingTextFieldViewModel(placeholder: "Valid", text: "banana@", validate: validated)
      let invalidVM = FloatingTextFieldViewModel(placeholder: "Invalid", text: "banana", validate: validated)

      FloatingTextField(viewModel: emptyVM)
      FloatingTextField(viewModel: emptyAndDisabledVM)
      FloatingTextField(viewModel: baseVM)
      FloatingTextField(viewModel: baseAndDisabledVM)
      FloatingTextField(viewModel: validVM)
      FloatingTextField(viewModel: invalidVM)
    }
    .padding()
  }
}
