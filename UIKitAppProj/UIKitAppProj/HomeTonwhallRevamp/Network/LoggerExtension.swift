//
//  LoggerExtension.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 07/02/24.
//

import Foundation
import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    /// All logs related to tracking and analytics.
    static let api = Logger(subsystem: subsystem, category: "API")
    
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}

class AppLog {
    
    static let shared = AppLog()
    
    private init() {
        
    }
    
    static func viewCycleInfoLog(_ message: Any) {
        Logger.viewCycle.info("\(String(describing: message))")
    }
    
    static func viewCycleNoticeLog(_ message: Any) {
        Logger.viewCycle.notice("\(String(describing: message))")
    }
    
    static func viewCycleDebugLog(_ message: Any) {
        Logger.viewCycle.debug("\(String(describing: message))")
    }
    
    static func viewCycleTraceLog(_ message: Any) {
        Logger.viewCycle.trace("\(String(describing: message))")
    }
    
    static func viewCycleWarningLog(_ message: Any) {
        Logger.viewCycle.warning("\(String(describing: message))")
    }
    
    static func viewCycleErrorLog(_ message: Any) {
        Logger.viewCycle.error("\(String(describing: message))")
    }
    
    static func viewCycleFaultLog(_ message: Any) {
        Logger.viewCycle.fault("\(String(describing: message))")
    }
    
    static func viewCycleCriticalLog(_ message: Any) {
        Logger.viewCycle.critical("\(String(describing: message))")
    }
    
    static func apiInfoLog(_ message: Any) {
        Logger.api.info("\(String(describing: message))")
    }
    
    static func apiNoticeLog(_ message: Any) {
        Logger.api.notice("\(String(describing: message))")
    }
    
    static func apiDebugLog(_ message: Any) {
        Logger.api.debug("\(String(describing: message))")
    }
    
    static func apiTraceLog(_ message: Any) {
        Logger.api.trace("\(String(describing: message))")
    }
    
    static func apiWarningLog(_ message: Any) {
        Logger.api.warning("\(String(describing: message))")
    }
    
    static func apiErrorLog(_ message: Any) {
        Logger.api.error("\(String(describing: message))")
    }
    
    static func apiFaultLog(_ message: Any) {
        Logger.api.fault("\(String(describing: message))")
    }
    
    static func apiCriticalLog(_ message: Any) {
        Logger.api.critical("\(String(describing: message))")
    }
    
    static func statisticsInfoLog(_ message: Any) {
        Logger.viewCycle.info("\(String(describing: message))")
    }
    
    static func statisticsNoticeLog(_ message: Any) {
        Logger.viewCycle.notice("\(String(describing: message))")
    }
    
    static func statisticsDebugLog(_ message: Any) {
        Logger.viewCycle.debug("\(String(describing: message))")
    }
    
    static func statisticsTraceLog(_ message: Any) {
        Logger.viewCycle.trace("\(String(describing: message))")
    }
    
    static func statisticsWarningLog(_ message: Any) {
        Logger.viewCycle.warning("\(String(describing: message))")
    }
    
    static func statisticsErrorLog(_ message: Any) {
        Logger.viewCycle.error("\(String(describing: message))")
    }
    
    static func statisticsFaultLog(_ message: Any) {
        Logger.viewCycle.fault("\(String(describing: message))")
    }
    
    static func statisticsCriticalLog(_ message: Any) {
        Logger.viewCycle.critical("\(String(describing: message))")
    }
}
