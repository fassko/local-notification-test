//
//  ViewController.swift
//  NotificationForegroundTest
//
//  Created by Kristaps Grinbergs on 05/10/2017.
//  Copyright © 2017 Kristaps Grinbergs. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    UNUserNotificationCenter.current().delegate = self
    
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound];
    
    center.requestAuthorization(options: options) {granted, error in
      if !granted {
        print("Something went wrong")
      }
    }
    
    center.getNotificationSettings { settings in
      switch settings.authorizationStatus {
      case .authorized:
        print("Authorized")
      case .denied, .notDetermined:
        print("Notifications not allowed")
      }
    }
  }
  
  @IBAction func show(_ sender: Any) {

    let content = UNMutableNotificationContent()
    content.title = "Test notification"
    content.body = "Hello from Mars!"
    content.sound = UNNotificationSound.default()
    let request = UNNotificationRequest(identifier: "test", content: content, trigger: nil)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
      print("error showing notification \(error)")
    })
  }
  
  // MARK: - UNUserNotificationCenterDelegate
  public func userNotificationCenter(_ center : UNUserNotificationCenter, willPresent notification : UNNotification, withCompletionHandler completionHandler : @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
}
