//
//  TypingIndicatorView.swift
//  CeedAdsIOSSample
//
//  Animated typing indicator with bouncing dots.
//

import SwiftUI
import Combine

struct TypingIndicatorView: View {
    @State private var animatingDot = 0
    @State private var timerCancellable: AnyCancellable?

    var body: some View {
        HStack {
            HStack(spacing: DesignSystem.Spacing.xxs) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(Color(.secondaryLabel))
                        .frame(width: DesignSystem.Size.typingDot, height: DesignSystem.Size.typingDot)
                        .offset(y: animatingDot == index ? DesignSystem.Size.typingDotBounce : 0)
                        .animation(
                            .easeInOut(duration: DesignSystem.Animation.typingDotDuration),
                            value: animatingDot
                        )
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.vertical, DesignSystem.Spacing.md)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(DesignSystem.CornerRadius.bubble)
            .padding(.horizontal)

            Spacer()
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private func startTimer() {
        timerCancellable = Timer.publish(
            every: DesignSystem.Animation.typingDotInterval,
            on: .main,
            in: .common
        )
        .autoconnect()
        .sink { _ in
            animatingDot = (animatingDot + 1) % 3
        }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}

#Preview {
    TypingIndicatorView()
}
