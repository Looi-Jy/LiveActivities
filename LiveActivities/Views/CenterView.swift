//
//  CenterView.swift
//  LiveActivities
//
//  Created by JyLooi on 09/05/2025.
//

import SwiftUI

struct CenterView: View {
    @Environment(DataProvider.self) var data: DataProvider
    
    var body: some View {
        HStack {
            Text(data.text)
            Text(data.emoji)
        }.padding()
    }
}

#Preview {
    CenterView()
        .environment(DataProvider(emoji: "🤩", text: "Star Eyes"))
}
