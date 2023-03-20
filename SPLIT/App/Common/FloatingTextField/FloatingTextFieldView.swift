import SwiftUI
import Combine

struct FloatingTextField: View {

  // MARK: - Properties -

  @ObservedObject var viewModel: FloatingTextFieldViewModel

  public var body: some View {
    ZStack {
      HStack {
        Text(self.viewModel.placeholder).padding()
          .font(self.viewModel.text.isEmpty ? .body : .caption)
          .foregroundColor(self.viewModel.text.isEmpty ? Color.gray : Color.gray.opacity(0.5))
          .offset(x: 0,
                  y: self.viewModel.text.isEmpty ? 0 : -12)
          .transition(.slide)
          .transition(.scale)

        Spacer()
      }
      TextField("", text: self.$viewModel.text)
        .offset(x: 0, y: self.viewModel.text.isEmpty ? 0 : 5)
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 10.0)
            .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
        )
    }
    .animation(.easeIn(duration: 0.1), value: self.viewModel.text)
  }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
      FloatingTextField(viewModel: FloatingTextFieldViewModel(placeholder: "Placeholder"))
    }
}
