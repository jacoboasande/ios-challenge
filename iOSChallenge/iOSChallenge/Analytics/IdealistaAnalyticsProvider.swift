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
    private var isProcessing = false

    func trackEvent(name: String, properties: [String: Any]) {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.eventQueue.append((name, properties))
            self.processQueueIfNeeded()
        }
    }

    private func processQueueIfNeeded() {
        guard !isProcessing else { return }
        isProcessing = true

        while !eventQueue.isEmpty {
            let event = eventQueue.removeFirst()
            let propsString = event.properties.map { "\($0.key): \($0.value)" }
                .joined(separator: ", ")
            print("IdealistaProvider -> trackEvent -> name: \(event.name) -> properties = [\(propsString)]")
        }

        isProcessing = false
    }
}
