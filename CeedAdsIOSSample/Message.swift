//
//  Message.swift
//  CeedAdsIOSSample
//

import Foundation
import CeedAdsSDK

/// Represents the role/type of a chat message
enum MessageRole {
    case user
    case ai
    case ad
}

/// Represents a single chat message in the conversation
struct Message: Identifiable {
    let id = UUID()
    let role: MessageRole
    let text: String
    let timestamp = Date()

    // Ad-specific properties (only used when role == .ad)
    let ad: ResolvedAd?
    let requestId: String?

    /// Convenience initializer for user/ai messages
    init(role: MessageRole, text: String) {
        self.role = role
        self.text = text
        self.ad = nil
        self.requestId = nil
    }

    /// Convenience initializer for ad messages
    init(ad: ResolvedAd, requestId: String?) {
        self.role = .ad
        self.text = ""
        self.ad = ad
        self.requestId = requestId
    }

    /// Legacy compatibility: check if message is from user
    var isUser: Bool {
        role == .user
    }
}
