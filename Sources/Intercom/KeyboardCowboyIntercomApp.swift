public struct KeyboardCowboyIntercomApp: IntercomApp {
  public let bundleIdentifier = "com.zenangst.Keyboard-Cowboy"

  public enum AppNotification: String,  StringRawRepresentable {
    case open = "OpenApp"
  }

  public typealias Notification = AppNotification
}
