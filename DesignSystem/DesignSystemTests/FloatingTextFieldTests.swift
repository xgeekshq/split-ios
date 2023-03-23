import XCTest
import SwiftUI
import SnapshotTesting

@testable import DesignSystem

final class FloatingTextFieldTests: XCTestCase {
  var viewModel: FloatingTextFieldViewModel?

  override func tearDownWithError() throws {
    viewModel = nil
  }

  func testEmptyFloatingTextFieldState() {
    viewModel = FloatingTextFieldViewModel()

    XCTAssertEqual(viewModel?.state, .empty)

    viewModel?.onChange(text: " ")
    XCTAssertNotEqual(viewModel?.state, .empty)

    viewModel?.onChange(text: "")
    viewModel?.isDisabled = true
    XCTAssertEqual(viewModel?.state, .empty)
  }

  func testBaseFloatingTextFieldState() {
    viewModel = FloatingTextFieldViewModel(text: "Hello")

    XCTAssertEqual(viewModel?.state, .base)

    viewModel?.onChange(text: " ")
    XCTAssertEqual(viewModel?.state, .base)

    viewModel?.isDisabled = true
    XCTAssertEqual(viewModel?.state, .base)
  }

  func testInvalidFloatingTextFieldState() {
    viewModel = FloatingTextFieldViewModel(text: "Hello", validateOnChange: .yes({ _ in return "error" }))
    XCTAssertEqual(viewModel?.state, .base)

    viewModel?.onChange(text: "Test")
    XCTAssertEqual(viewModel?.state, .invalid)
    XCTAssertEqual(viewModel?.errorMessage, "error")

    viewModel?.isDisabled = true
    XCTAssertEqual(viewModel?.state, .base)
  }

  func testValidFloatingTextFieldState() {
    viewModel = FloatingTextFieldViewModel(text: "Hello", validateOnChange: .yes({ _ in return nil }))
    XCTAssertEqual(viewModel?.state, .base)

    viewModel?.onChange(text: "Test")
    XCTAssertEqual(viewModel?.state, .valid)
    XCTAssertEqual(viewModel?.errorMessage, "")

    viewModel?.isDisabled = true
    XCTAssertEqual(viewModel?.state, .base)
  }

  func testValidateFloatingTextField() {
    let handler = { text -> String? in
      if text == "valid" { return nil }

      return "error"
    }

    viewModel = FloatingTextFieldViewModel()
    
    viewModel?.onChange(text: "invalid")
    XCTAssertFalse(viewModel!.validate(with: handler))
    XCTAssertEqual(viewModel!.state, .invalid)

    viewModel?.onChange(text: "valid")
    XCTAssertTrue(viewModel!.validate(with: handler))
    XCTAssertEqual(viewModel!.state, .valid)
  }

  func testFloatingTextFieldView() {
    assertSnapshot(
      matching: UIHostingController(rootView: FloatingTextField_Previews.previews),
      as: .image(on: .iPhone13Pro)
    )
  }
}
