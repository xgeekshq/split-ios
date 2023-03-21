import Foundation

enum Validated<Value, Error> {
  case valid(Value)
  case invalid([Error])
}
