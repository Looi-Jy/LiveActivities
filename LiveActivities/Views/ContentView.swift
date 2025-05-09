//
//  ContentView.swift
//  LiveActivities
//
//  Created by JyLooi on 09/05/2025.
//

import SwiftUI

struct ContentView: View {
    private let controller = LiveActivitiesController()
    
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                controller.startActivity()
            }, label: {
                Text("Start Live Activities")
            })
            
            Button(action: {
                controller.updateActivity()
            }, label: {
                Text("Update Live Activities")
            })
            
            Button(action: {
                controller.endActivity()
            }, label: {
                Text("End Live Activities")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
