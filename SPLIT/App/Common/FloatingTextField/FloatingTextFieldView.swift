import SwiftUI
import Combine

struct FloatingTextField: View {

  // MARK: - Properties -

  @ObservedObject var viewModel: FloatingTextFieldViewModel
  @State var style: FloatingTextFieldStyle
  @State var text: String

  init(viewModel: FloatingTextFieldViewModel) {
    self.viewModel = viewModel
    self.text = viewModel.text
    self.style = FloatingTextFieldStyleProvider.style(for: viewModel.state, isDisabled: viewModel.isDisabled)
  }

  public var body: some View {
      ZStack {
        placeholderLabel
        floatingTextField
      }
      .background(style.backgroundColor)
      .animation(.easeIn(duration: 0.1), value: viewModel.state)
      .onChange(of: text) { viewModel.onChange(text: $0) }
      .onChange(of: viewModel.state) { newValue in
        self.style = FloatingTextFieldStyleProvider.style(for: viewModel.state, isDisabled: viewModel.isDisabled)
      }
    if viewModel.state == .invalid {
        errorStackView.animation(.easeIn(duration: 10), value: viewModel.state)
      }
  }

  var placeholderLabel: some View {
    HStack {
      Text(viewModel.placeholder)
        .font(style.placeholderFont)
        .foregroundColor(style.placeholderColor)
        .offset(style.placeholderOffset)
        .padding()
        .transition(.slide)
        .transition(.scale)
      Spacer()
    }
  }

  var errorStackView: some View {
    HStack {
      Image(uiImage: Images.Icons.alert)
        .renderingMode(.template)
        .resizable()
        .frame(width: 13.0, height: 13.0)
        .foregroundColor(Colors.Danger.Base)
      Text(viewModel.errorMessage)
        .font(FontConstants.font(for: 12, in: .regular))
        .foregroundColor(Colors.Danger.Base)
      Spacer()
    }.transition(.slide)
  }

  var floatingTextField: some View {
    TextField("", text: $text)
      .offset(style.textOffset)
      .font(style.textfieldFont)
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: style.borderCornerRadius)
          .stroke(style.shadowColor, style: StrokeStyle(lineWidth: style.shadowlineWidth))
      )
      .overlay(
        RoundedRectangle(cornerRadius: style.borderCornerRadius)
          .stroke(style.borderColor, style: StrokeStyle(lineWidth: style.borderlineWidth))
          .padding(1)
      )
      .disabled(viewModel.isDisabled)
  }
}

struct FloatingTextField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      let validated: (String) -> String? = { text in
        if text.contains("@") { return nil}

        return "Error"
      }

      let emptyVM = FloatingTextFieldViewModel(placeholder: "Empty",  validateOnChange: .yes(validated))
      let emptyAndDisabledVM = FloatingTextFieldViewModel(placeholder: "Empty&Disabled", isDisabled: true,  validateOnChange: .yes(validated))
      let baseVM = FloatingTextFieldViewModel(placeholder: "Base", text: "banana", validateOnChange: .no)
      let baseAndDisabledVM = FloatingTextFieldViewModel(placeholder: "Base&Disabled", text: "banana", isDisabled: true,  validateOnChange: .yes(validated))
      let validVM = FloatingTextFieldViewModel(placeholder: "Valid", text: "banana@", validateOnChange: .yes(validated))
      let invalidVM = FloatingTextFieldViewModel(placeholder: "Invalid", text: "banana", validateOnChange: .yes(validated))

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
