import SwiftUI
import DesignSystem

@main
struct SPLITApp: App {
    var body: some Scene {
        WindowGroup {
          create()
        }
    }

  func create() -> some View {
    let vm = FloatingTextFieldViewModel(placeholder: "Placeholder")
    let view = FloatingTextField(viewModel: vm)
    return view
  }
}
