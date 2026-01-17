//
//  MessageBubbleView.swift
//  CeedAdsIOSSample
//

import SwiftUI

struct MessageBubbleView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.role == .user {
                Spacer()
            }

            Text(message.text)
                .padding(DesignSystem.Spacing.md)
                .background(bubbleBackground)
                .foregroundColor(bubbleForeground)
                .cornerRadius(DesignSystem.CornerRadius.bubble)

            if message.role != .user {
                Spacer()
            }
        }
        .padding(.horizontal)
    }

    /// Adaptive background color for dark/light mode
    private var bubbleBackground: Color {
        if message.role == .user {
            return .blue
        } else {
            // Uses system secondary background - adapts to dark mode
            return Color(.secondarySystemBackground)
        }
    }

    /// Adaptive text color for dark/light mode
    private var bubbleForeground: Color {
        if message.role == .user {
            return .white
        } else {
            // Uses primary label color - adapts to dark mode
            return Color(.label)
        }
    }
}

#Preview {
    VStack {
        MessageBubbleView(message: Message(role: .user, text: "Hello!"))
        MessageBubbleView(message: Message(role: .ai, text: "Hi there!"))
    }
}
