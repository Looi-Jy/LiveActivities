//
//  LiveActivitiesController.swift
//  LiveActivities
//
//  Created by JyLooi on 09/05/2025.
//
import ActivityKit
import OSLog

final class LiveActivitiesController {
    
    private var currentActivity: Activity<LiveActivitiesWidgetAttributes>? = nil
    private var data: DataProvider = DataProvider(emoji: "", text: "")
    
    func getPushToStartToken() {
        Task {
            for await data in Activity<LiveActivitiesWidgetAttributes>.pushToStartTokenUpdates {
                let token = data.map {String(format: "%02x", $0)}.joined()
                Logger.liveActivities.info("Activity PushToStart Token: \(token, privacy: .public)")
                //TODO: Token for start live activities, send this token to your notification server
            }
        }
    }
    
    func startActivity() {
        if ActivityAuthorizationInfo().areActivitiesEnabled,
           !Activity<LiveActivitiesWidgetAttributes>.activities.isEmpty {
            endActivity()
        }
        
        do {
            data.emoji = "🤩"
            data.text = "Starting Live Activities"
            let attribute = LiveActivitiesWidgetAttributes(name: "LiveActivities")
            let initState = LiveActivitiesWidgetAttributes.ContentState(data: data)
            let activity = try Activity.request(
                attributes: attribute,
                content: .init(state: initState, staleDate: nil),
                pushType: .token
            )
            currentActivity = activity
            Logger.liveActivities.info("Start Live Activities: \(activity.content.description)")
        } catch {
            Logger.liveActivities.info("Failed to start Live Activities: \(error.localizedDescription)")
        }
    }
    
    func updateActivity() {
        Task {
            guard let activity = currentActivity else { return }
            
            data.emoji = "😀"
            data.text = "Updating Live Activities"
            let contentState = LiveActivitiesWidgetAttributes.ContentState(data: data)
            await activity.update(ActivityContent(state: contentState, staleDate: nil))
        }
    }
    
    func endActivity() {
        Task {
            guard let activity = currentActivity else { return }
            
            data.emoji = "✋"
            data.text = "Ending Live Activities"
            let finalState = LiveActivitiesWidgetAttributes.ContentState(data: data)
            await activity.end(ActivityContent(state: finalState, staleDate: nil), dismissalPolicy: .after(.now + 10))
        }
    }
}
