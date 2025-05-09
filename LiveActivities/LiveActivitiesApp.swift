//
//  LiveActivitiesApp.swift
//  LiveActivities
//
//  Created by JyLooi on 09/05/2025.
//

import ActivityKit
import OSLog
import SwiftUI

@main
struct LiveActivitiesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        LiveActivitiesController().getPushToStartToken()
        observeActivityPushTokenAndState()
                
        let authOptions: UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (granted, error) in
            print(granted,error ?? "")
        }
        application.registerForRemoteNotifications()

        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        print("APNs device token: \(deviceTokenString)")
    }
    
}

extension AppDelegate {
    func observeActivityPushTokenAndState() {
        Task {
            for await activity in Activity<LiveActivitiesWidgetAttributes>.activityUpdates {
                Task {
                    for await tokenData in activity.pushTokenUpdates {
                        let token = tokenData.map {String(format: "%02x", $0)}.joined()
                        Logger.liveActivities.info("Observer Activity:\(activity.id, privacy: .public) Push token: \(token,privacy: .public)")
                        //TODO: Token for live activities update * end, send this token to your notification server
                    }
                }
                
                Task {
                    for await state in activity.activityStateUpdates {
                        let stateLog = "Observer Activity:\(activity.id) state:\(state)"
                        Logger.liveActivities.info("\(stateLog, privacy: .public)")
                        if state == .stale {
                            LiveActivitiesController().endActivity()
                        }
                    }
                }
            }
        }
    }
}
