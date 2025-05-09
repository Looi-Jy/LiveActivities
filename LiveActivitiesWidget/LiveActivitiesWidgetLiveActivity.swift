//
//  LiveActivitiesWidgetLiveActivity.swift
//  LiveActivitiesWidget
//
//  Created by JyLooi on 09/05/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        static func == (lhs: LiveActivitiesWidgetAttributes.ContentState, rhs: LiveActivitiesWidgetAttributes.ContentState) -> Bool {
            lhs.data == rhs.data
        }
        
        func hash(into hasher: inout Hasher) {
            return hasher.combine(data)
        }
        
        // Dynamic stateful properties about your activity go here!
        var data: DataProvider
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LiveActivitiesWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    TopLeftView()
                    Spacer()
                    TopRightView()
                }.padding()
                CenterView()
            }
            .environment(context.state.data)
            .activityBackgroundTint(Color.white)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    TopLeftView()
                }
                DynamicIslandExpandedRegion(.trailing) {
                    TopRightView()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        CenterView()
                    }
                    .environment(context.state.data)
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.data.emoji)")
            } minimal: {
                Text(context.state.data.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveActivitiesWidgetAttributes {
    fileprivate static var preview: LiveActivitiesWidgetAttributes {
        LiveActivitiesWidgetAttributes(name: "World")
    }
}

extension LiveActivitiesWidgetAttributes.ContentState {
    fileprivate static var smiley: LiveActivitiesWidgetAttributes.ContentState {
        LiveActivitiesWidgetAttributes.ContentState(data: DataProvider(emoji: "😀", text: "Smiley"))
     }
     
     fileprivate static var starEyes: LiveActivitiesWidgetAttributes.ContentState {
         LiveActivitiesWidgetAttributes.ContentState(data: DataProvider(emoji: "🤩", text: "Star Eyes"))
     }
}

#Preview("Notification", as: .content, using: LiveActivitiesWidgetAttributes.preview) {
   LiveActivitiesWidgetLiveActivity()
} contentStates: {
    LiveActivitiesWidgetAttributes.ContentState.smiley
    LiveActivitiesWidgetAttributes.ContentState.starEyes
}
