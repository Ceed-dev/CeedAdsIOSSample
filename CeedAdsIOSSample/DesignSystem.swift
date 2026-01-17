//
//  DesignSystem.swift
//  CeedAdsIOSSample
//
//  Design constants for consistent styling across the app.
//

import SwiftUI

enum DesignSystem {
    // MARK: - Spacing

    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 6
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 40
    }

    // MARK: - Corner Radius

    enum CornerRadius {
        static let small: CGFloat = 4
        static let medium: CGFloat = 6
        static let large: CGFloat = 12
        static let bubble: CGFloat = 16
    }

    // MARK: - Animation

    enum Animation {
        static let typingDotInterval: TimeInterval = 0.3
        static let typingDotDuration: Double = 0.3
        static let responseDelayMin: Double = 0.7
        static let responseDelayMax: Double = 1.3

        static var randomResponseDelay: Double {
            Double.random(in: responseDelayMin...responseDelayMax)
        }
    }

    // MARK: - Sizes

    enum Size {
        static let typingDot: CGFloat = 8
        static let typingDotBounce: CGFloat = -4
        static let sendButtonPadding: CGFloat = 10
    }
}
