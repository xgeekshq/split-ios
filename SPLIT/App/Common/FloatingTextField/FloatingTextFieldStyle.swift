import Foundation
import SwiftUI

struct FloatingTextFieldStyle {
  let borderColor: Color
  let shadowColor: Color
  let backgroundColor: Color
  let textOffset: CGSize
  let placeholderOffset: CGSize
  let placeholderColor: Color = Colors.Primary.Lighter
  let placeholderFont: Font
  let textfieldFont: Font = FontConstants.font(for: 16)
  let borderCornerRadius: CGFloat = 4.0
  let borderlineWidth: CGFloat = 1.0
  let shadowlineWidth: CGFloat = 3.0
}

struct FloatingTextFieldStyleProvider {
  static func style(for state: FloatingTextFieldState, isDisabled: Bool = false) -> FloatingTextFieldStyle {
    let backgroundColor = isDisabled ? Colors.Primary.Lightest : .clear

    switch state {
      case .empty:
        return FloatingTextFieldStyle(
          borderColor: Colors.Primary.Lighter,
          shadowColor: .clear,
          backgroundColor: backgroundColor,
          textOffset: CGSize(width: 0, height: 0),
          placeholderOffset: CGSize(width: 0, height: 0),
          placeholderFont: FontConstants.font(for: 16)
        )
      case .base:
        return FloatingTextFieldStyle(
          borderColor: Colors.Primary.Lighter,
          shadowColor: .clear,
          backgroundColor: backgroundColor,
          textOffset: CGSize(width: 0, height: 8),
          placeholderOffset: CGSize(width: 0, height: -12),
          placeholderFont: FontConstants.font(for: 14)
        )
      case .valid:
        return FloatingTextFieldStyle(
          borderColor: Colors.Highlight1.Dark,
          shadowColor: Colors.Highlight1.Lightest,
          backgroundColor: backgroundColor,
          textOffset: CGSize(width: 0, height: 8),
          placeholderOffset: CGSize(width: 0, height: -12),
          placeholderFont: FontConstants.font(for: 14)
        )
      case .invalid:
      return FloatingTextFieldStyle(
          borderColor: Colors.Danger.Dark,
          shadowColor: Colors.Danger.Lightest,
          backgroundColor: backgroundColor,
          textOffset: CGSize(width: 0, height: 8)
          , placeholderOffset: CGSize(width: 0, height: -12),
          placeholderFont: FontConstants.font(for: 14)
        )
    }
  }
}
