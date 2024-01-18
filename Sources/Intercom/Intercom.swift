import Cocoa
import Combine

public final class Intercom<App: IntercomApp> {
  private let appType: any IntercomApp.Type
  private let app: any IntercomApp

  public init(_ appType: App.Type) {
    self.app = appType.init()
    self.appType = appType
  }

  public func isRunning() -> Bool {
    NSRunningApplication.runningApplications(withBundleIdentifier: appType.bundleIdentifier).isEmpty == false
  }

  public func receive(_ notification: App.Notification, block: @escaping (Notification) -> Void) -> AnyCancellable {
    let rawValue = appType.bundleIdentifier  + "." + notification.rawValue
    let name = Notification.Name(rawValue: rawValue)
    return DistributedNotificationCenter.default()
      .publisher(for: name)
      .sink { [app] notification in
        guard let sender = notification.userInfo?["Sender"] as? String,
              app.acceptedSenders.contains(sender) else {
          return
        }
        block(notification)
      }
  }

  public func send(_ notification: App.Notification, userInfo: [AnyHashable: Any]? = nil) {
    var userInfo = userInfo ?? [:]

    if let bundleIdentifier = Bundle.main.bundleIdentifier {
      userInfo["Sender"] = bundleIdentifier
    }

    let rawValue = appType.bundleIdentifier  + "." + notification.rawValue
    let name = Notification.Name(rawValue: rawValue)
    DistributedNotificationCenter.default()
      .post(name: name, object: nil, userInfo: userInfo)
  }
}
