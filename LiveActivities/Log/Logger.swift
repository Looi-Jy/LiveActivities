//
//  Logger.swift
//  LiveActivities
//
//  Created by JyLooi on 09/05/2025.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let liveActivities = Logger(subsystem: subsystem, category: "LiveActivities")
}
