//
//  TraceCollector.swift
//  
//
//  Created by Murat Yakici on 14/06/2021.
//

import Foundation
import os

/// Collects trace and debugging information for each 'check' session.
final class TraceCollector {

    let queue = DispatchQueue(label: "id.tru.tracecollector.queue")
    //let traceLog = OSLog(subsystem: "id.tru.sdk", category: "trace")
    //os_log("", log: traceLog, type: .fault, "")

    private var trace = ""
    private var isTraceEnabled = false

    private var debugInfo = DebugInfo()
    var isDebugInfoCollectionEnabled = false
    var isConsoleLogsEnabled = false

    /// Stops trace and clears the internal buffer
    func startTrace() {
        queue.sync() {
            if !isTraceEnabled {
                isTraceEnabled = true
                //
                trace.removeAll()
                debugInfo.clear()
                //
                trace.append("\(deviceInfo())\n")
                debugInfo.add(log:"\(deviceInfo())\n")
            } else {
                os_log("%s", type:.error, "Trace already started. Use stopTrace before restaring..")
            }
        }
    }

    /// Stops trace and clears the internal buffer. Collection of debug information also stops, if enabled prior to startTrace().
    func stopTrace() {
        queue.sync() {
            isTraceEnabled = false
            isDebugInfoCollectionEnabled = false
            isConsoleLogsEnabled = false
            //
            trace.removeAll()
            debugInfo.clear()
        }
    }

    /// Provides the TraceInfo recorded
    func traceInfo() -> TraceInfo {
        queue.sync() {
            return TraceInfo(trace: trace, debugInfo: debugInfo)
        }
    }

    /// Records a trace. Add a newline at the end of the log.
    func addTrace(log: String) {
        queue.async {
            if self.isTraceEnabled {
                self.trace.append("\(log)\n")
            }
        }
    }

    func addDebug(type: OSLogType = .debug, tag: String? = "Tru.ID", log: String) {
        queue.async {
            if self.isDebugInfoCollectionEnabled {
                self.debugInfo.add(tag: tag, log: log)
            }
        }
        if self.isConsoleLogsEnabled {
            os_log("%s", type:type, log)
        }
    }

    func now() -> String {
        debugInfo.dateUtils.now()
    }

}

public class DebugInfo {

    internal let dateUtils = DateUtils()
    private var bufferMap = Dictionary<String, String>()

    func add(tag: String? = nil, log: String) {
        guard let tag = tag else {
            self.bufferMap[dateUtils.now()] = "\(log)"
            return
        }
        self.bufferMap[dateUtils.now()] = "\(tag) - \(log)"
    }

    func clear() {
        bufferMap.removeAll()
    }

    func toString() -> String {
        var stringBuffer = ""
        for key in bufferMap.keys.sorted() {
            guard let value = bufferMap[key] else { break }
            stringBuffer += "\(key): \(value)"
        }
        return stringBuffer
    }
}

struct TraceInfo {
    let trace: String
    let debugInfo: DebugInfo
}

func isoTimestampUsingCurrentTimeZone() -> String {
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.timeZone = TimeZone.current
    let timestamp = isoDateFormatter.string(from: Date())
    return timestamp
}

class DateUtils {

    lazy var df: ISO8601DateFormatter = {
        let d = ISO8601DateFormatter()
        d.formatOptions = [
            .withInternetDateTime,
            .withDashSeparatorInDate,
            .withFullDate,
            .withFractionalSeconds,
            .withColonSeparatorInTimeZone
        ]
        return d
    }()

    func now() -> String {
        df.string(from: Date())
    }
}
