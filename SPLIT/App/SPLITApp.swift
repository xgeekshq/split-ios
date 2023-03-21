import SwiftUI

@main
struct SPLITApp: App {
    var body: some Scene {
        WindowGroup {
          FloatingTextField(viewModel: FloatingTextFieldViewModel(placeholder: "Placeholder"))
        }
    }
}
