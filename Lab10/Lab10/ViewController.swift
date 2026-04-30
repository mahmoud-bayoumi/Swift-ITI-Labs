//
//  ViewController.swift
//  Lab10
//
//  Created by Bayoumi on 30/04/2026.
//

import UIKit
//import UserNotifications // Required for local notifications

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var notificationCenter : UNUserNotificationCenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter = UNUserNotificationCenter.current()
        authorizeNotifications()
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func authorizeNotifications() {
        notificationCenter!.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Auth Error: \(error)")
            }
        }
    }


    @IBAction func tenSecondsBtnAction(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "10 Seconds Timeout!"
        content.body = "This notification used a Time Interval trigger."
        content.sound = .default
        
      
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "tenSecTimer", content: content, trigger: trigger)
        notificationCenter!.add(request)
        print("Successfully scheduled for 10 seconds notification")
    }
    
    @IBAction func setReminderBtnAction(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Specific Reminder"
        content.body = "This is the alert you set for a specific time."
        content.sound = .default
        
        let selectedDate = datePicker.date
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter!.add(request) { error in
            if error == nil {
                print("Successfully scheduled for local time components: \(components.hour!):\(components.minute!)")
            }
        }
    }
}

// MARK: - Notification Delegate
extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Notification tapped! Identifier: \(response.notification.request.identifier)")
        
        // Ensure we are on the main thread for UI changes
        DispatchQueue.main.async {
            if let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") {
                if let nav = self.navigationController {
                    nav.pushViewController(secondVC, animated: true)
                } else {
                      print("No Nav Controller found - presenting modally instead.")
                    self.present(secondVC, animated: true)
                }
            } else {
                print("Could not find SecondVC in Storyboard. Check your Storyboard ID!")
            }
        }
        
        completionHandler()
    }

}
