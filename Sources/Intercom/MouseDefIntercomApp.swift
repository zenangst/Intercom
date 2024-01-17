public struct MouseDefIntercomApp: IntercomApp {
  public let bundleIdentifier = "com.zenangst.MouseDef"

  public enum AppNotification: String,  StringRawRepresentable {
    case snapToFullscreen = "SnapToFullscreen"
  }
  
  public typealias Notification = AppNotification
}
