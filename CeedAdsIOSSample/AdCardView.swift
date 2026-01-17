//
//  AdCardView.swift
//  CeedAdsIOSSample
//
//  Placeholder view for rendering ads in the chat.
//  This will be replaced with the actual SDK's renderAd() equivalent.
//

import SwiftUI

/// Renders an ad card in the chat timeline
/// Equivalent to the Web SDK's InlineAdCard component
struct AdCardView: View {
    let ad: ResolvedAd
    let requestId: String?

    var body: some View {
        HStack {
            // Ads appear on the left side (like AI messages)
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                // Ad badge
                Text("Ad")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.secondaryLabel))
                    .padding(.horizontal, DesignSystem.Spacing.xs)
                    .padding(.vertical, 2)
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(DesignSystem.CornerRadius.small)

                // Ad content
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(ad.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.label))

                    Text(ad.description)
                        .font(.caption)
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(2)

                    // Action button
                    Button(action: onLearnMoreTapped) {
                        Text("Learn More")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.horizontal, DesignSystem.Spacing.md)
                            .padding(.vertical, DesignSystem.Spacing.xs)
                            .background(Color.blue)
                            .cornerRadius(DesignSystem.CornerRadius.medium)
                    }
                }
                .padding(DesignSystem.Spacing.md)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(DesignSystem.CornerRadius.large)
                .overlay(
                    RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large)
                        .stroke(Color(.separator), lineWidth: 1)
                )
            }
            .padding(.horizontal)

            Spacer()
        }
    }

    private func onLearnMoreTapped() {
        // TODO(shungo): Implement click tracking and open URL
        // In the real SDK, this would:
        // 1. Track the click event
        // 2. Open the actionUrl in Safari
        print("Ad clicked: \(ad.id), requestId: \(requestId ?? "nil")")

        if let url = URL(string: ad.actionUrl) {
            // UIApplication.shared.open(url)
            print("Would open URL: \(url)")
        }
    }
}

#Preview {
    AdCardView(
        ad: ResolvedAd(
            id: "preview-ad",
            title: "Learn Swift Today",
            description: "Start your iOS development journey with our comprehensive Swift course.",
            imageUrl: nil,
            actionUrl: "https://example.com"
        ),
        requestId: "preview-request"
    )
}
