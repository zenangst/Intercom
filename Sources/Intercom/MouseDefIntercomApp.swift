public struct MouseDefIntercomApp: IntercomApp {
  public static let bundleIdentifier = "com.zenangst.MouseDef"
  public var acceptedSenders = [
    KeyboardCowboyIntercomApp.bundleIdentifier
  ]

  public enum AppNotification: String,  StringRawRepresentable {
    case snapToFullscreen = "SnapToFullscreen"
  }
  
  public typealias Notification = AppNotification

  public init() {}
}
