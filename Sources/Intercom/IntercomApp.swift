public protocol IntercomNotification {}
public protocol StringRawRepresentable: RawRepresentable where RawValue == String, Self: IntercomNotification {}

public protocol IntercomApp {
  static var bundleIdentifier: String { get }
  var acceptedSenders: [String] { get }
  associatedtype Notification: StringRawRepresentable

  init()
}
