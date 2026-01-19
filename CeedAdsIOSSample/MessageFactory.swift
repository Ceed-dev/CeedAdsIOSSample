//
//  MessageFactory.swift
//  CeedAdsIOSSample
//
//  Factory methods for creating Message instances.
//

import Foundation
import CeedAdsSDK

enum MessageFactory {
    /// Create a user message
    static func userMessage(_ text: String) -> Message {
        Message(role: .user, text: text)
    }

    /// Create an AI message
    static func aiMessage(_ text: String) -> Message {
        Message(role: .ai, text: text)
    }

    /// Create an ad message
    static func adMessage(_ ad: ResolvedAd, requestId: String?) -> Message {
        Message(ad: ad, requestId: requestId)
    }
}
