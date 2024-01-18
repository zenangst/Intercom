public struct KeyboardCowboyIntercomApp: IntercomApp {
  public static let bundleIdentifier = "com.zenangst.Keyboard-Cowboy"
  public var acceptedSenders = [String]()

  public enum AppNotification: String,  StringRawRepresentable {
    case open = "OpenApp"
  }

  public typealias Notification = AppNotification

  public init() {}
}
