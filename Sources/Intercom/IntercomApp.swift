public protocol IntercomNotification {}
public protocol StringRawRepresentable: RawRepresentable where RawValue == String, Self: IntercomNotification {}

public protocol IntercomApp {
  var bundleIdentifier: String { get }
  associatedtype Notification: StringRawRepresentable
}
