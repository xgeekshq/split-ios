import Foundation
import SwiftUI

enum FloatingTextFieldStyle {
  case empty
  case base
  case valid
  case error
  case emptyAndDisabled
  case baseAndDisabled
}

extension FloatingTextFieldStyle {
  var borderColor: Color {
    switch self {
      case .valid:
        return Colors.Highlight1.Dark
      case .error:
        return Colors.Danger.Dark
      default:
        return Colors.Primary.Lighter
    }
  }

  var shadowColor: Color {
    switch self {
      case .valid:
        return Colors.Highlight1.Lightest
      case .error:
        return Colors.Danger.Lightest
      default:
        return .clear
    }
  }

  var backgroundColor: Color {
    switch self {
      case .baseAndDisabled, .emptyAndDisabled:
        return Colors.Primary.Lightest
      default:
        return .clear
    }
  }

  var textOffset: CGSize {
    switch self {
      case .empty, .emptyAndDisabled:
        return CGSize(width: 0, height: 0)
      default:
        return CGSize(width: 0, height: 8)
    }
  }

  var placeholderOffset: CGSize {
    switch self {
      case .empty, .emptyAndDisabled:
        return CGSize(width: 0, height: 0)
      default:
        return CGSize(width: 0, height: -12)
    }
  }

  var placeholderColor: Color {
    Colors.Primary.Lighter
  }

  var placeholderFont: Font {
    switch self {
      case .empty, .emptyAndDisabled:
        return FontConstants.font(for: 16)
      default:
        return FontConstants.font(for: 14)
    }
  }

  var textfieldFont: Font {
    FontConstants.font(for: 16)
  }

  var borderCornerRadius: CGFloat {
    return 4
  }

  var borderLineWidth: CGFloat {
    return 1
  }

  var shadowLineWidth: CGFloat {
    return 3
  }
}
