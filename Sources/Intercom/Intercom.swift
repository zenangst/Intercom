import Cocoa
import Combine

public final class Intercom<App: IntercomApp> {
  private let app: App

  public init(_ app: App) {
    self.app = app
  }

  public func receive(_ notification: App.Notification, block: @escaping (Notification) -> Void) -> NotificationCenter.Publisher {
    let rawValue = app.bundleIdentifier  + "." + notification.rawValue
    let name = Notification.Name(rawValue: rawValue)
    return DistributedNotificationCenter.default()
      .publisher(for: name)
  }

  public func send(_ notification: App.Notification, userInfo: [AnyHashable: Any]? = nil) {
    var userInfo = userInfo ?? [:]

    if let bundleIdentifier = Bundle.main.bundleIdentifier {
      userInfo["Sender"] = bundleIdentifier
    }

    let rawValue = app.bundleIdentifier  + "." + notification.rawValue
    let name = Notification.Name(rawValue: rawValue)
    DistributedNotificationCenter.default()
      .post(name: name, object: nil, userInfo: userInfo)
  }
}
