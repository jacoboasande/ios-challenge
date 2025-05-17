//
//  IdealistaAnalyticsProvider.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

import Foundation

final class IdealistaAnalyticsProvider: AnalyticsProvider {
    private var eventQueue: [(name: String, properties: [String: Any])] = []
    private let queue = DispatchQueue(label: "com.idealista.analytics")

    func trackEvent(name: String, properties: [String: Any]) {
        queue.async { [weak self] in
            self?.eventQueue.append((name, properties))
            self?.processQueue()
        }
    }

    private func processQueue() {
        while !eventQueue.isEmpty {
            let event = eventQueue.removeFirst()
            let propsString = event.properties.map { "\($0.key): \($0.value)" }
                .joined(separator: ", ")
            print("IdealistaProvider -> trackEvent -> name: \(event.name) -> properties = [\(propsString)]")
        }
    }
}
