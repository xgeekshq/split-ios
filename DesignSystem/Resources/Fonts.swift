import Foundation
import SwiftUI

struct FontConstants {

  private static let baseName = "DMSans"

  private init() {}

  enum FontWeight: String {
    case bold = "Bold"
    case regular = "Regular"
    case medium = "Medium"
  }

  static func font(for size: CGFloat, in fontWeight: FontWeight = .regular) -> Font {
    return Font.custom(baseName + "-" + fontWeight.rawValue, size: size)
  }
}
