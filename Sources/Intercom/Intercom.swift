import Cocoa
import Combine

public final class Intercom<App: IntercomApp> {
  private let appType: any IntercomApp.Type
  private let app: any IntercomApp
  private let notificationCenter = DistributedNotificationCenter.default()
  private var onReceive: ((Notification) -> Void)?

  public init(_ appType: App.Type, onReceive: ((Notification) -> Void)? = nil) {
    self.app = appType.init()
    self.appType = appType
    self.onReceive = onReceive
  }

  public func isRunning() -> Bool {
    NSRunningApplication.runningApplications(withBundleIdentifier: appType.bundleIdentifier).isEmpty == false
  }

  public func receive(_ notification: App.Notification, onRecieve: @escaping (Notification) -> Void) -> AnyCancellable {
    let rawValue = appType.bundleIdentifier  + "." + notification.rawValue
    let name = Notification.Name(rawValue: rawValue)
    return notificationCenter
      .publisher(for: name)
      .sink { [app] notification in
        guard let sender = notification.userInfo?["Sender"] as? String,
              let notificationName = notification.userInfo?["Notification"] as? String,
              app.acceptedSenders.contains(sender),
              rawValue == notificationName
        else { return }

        onRecieve(notification)
      }
  }

  public func send(_ notification: App.Notification, userInfo: [AnyHashable: Any]? = nil) {
    var userInfo = userInfo ?? [:]

    if let bundleIdentifier = Bundle.main.bundleIdentifier {
      userInfo["Sender"] = bundleIdentifier
    }

    let rawValue = appType.bundleIdentifier  + "." + notification.rawValue
    let name = Notification.Name(rawValue: rawValue)
    userInfo["Notification"] = rawValue
    notificationCenter.postNotificationName(name, object: nil, userInfo: userInfo, deliverImmediately: true)
  }
}
