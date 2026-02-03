//
//  ChatViewModel.swift
//  CeedAdsIOSSample
//
//  ViewModel for ChatView that handles all business logic.
//

import Foundation
import SwiftUI
import CeedAdsSDK

// MARK: - Ad Format Preferences
//
// Different scenarios benefit from different ad formats:
//
// | Scenario      | Recommended Formats      | Rationale                          |
// |---------------|--------------------------|-----------------------------------|
// | english       | [.actionCard]            | Traditional CTA for apps/courses  |
// | programming   | [.actionCard]            | Course and tool recommendations   |
// | programmingJa | [.actionCard]            | Japanese course recommendations   |
// | travel        | [.actionCard]            | Hotel and travel service CTAs     |
// | leadGen       | [.leadGen]               | Newsletter email capture          |
// | staticAd      | [.staticAd]              | Event/promotion banner display    |
// | followup      | [.followup]              | Survey/feedback engagement        |
//
// Usage (when SDK supports formats parameter):
// ```swift
// let (ad, requestId) = try await CeedAdsSDK.requestAd(
//     conversationId: conversationId,
//     messageId: messageId,
//     contextText: contextText,
//     formats: [.leadGen]  // Request only lead_gen format ads
// )
// ```

// MARK: - ChatViewModel

/// ViewModel that manages the chat state and coordinates between the UI and SDK.
///
/// Responsibilities:
/// - Manages chat messages (user, AI, and ads)
/// - Handles scenario detection and progression
/// - Communicates with CeedAdsSDK for ad requests
/// - Provides UI state (thinking indicator, input text)
@Observable
final class ChatViewModel {

    // MARK: - Constants

    /// Conversation ID used for demo purposes
    private let demoConversationId = "demo-conv"

    /// App ID for SDK initialization
    private let testAppId = "test-app"

    /// Fallback message when no scenario is detected
    private let fallbackMessage = "I can assist with English learning, programming, travel planning, newsletters, events, or feedback surveys. Which one are you interested in?"

    /// Message shown when scenario is complete
    private let scenarioCompleteMessage = "Thanks! Let me know if you need anything else."

    // MARK: - Published Properties

    /// All messages in the current conversation
    private(set) var messages: [Message] = []

    /// Current text in the input field
    var inputText: String = ""

    /// Whether the AI is "thinking" (showing typing indicator)
    private(set) var isThinking: Bool = false

    // MARK: - Private Properties

    /// Manages scenario state and progression
    private let scenarioManager = ScenarioManager()

    // MARK: - Public Methods

    /// Sends the current input message and triggers scenario/ad logic.
    ///
    /// Flow:
    /// 1. Validates and adds user message
    /// 2. Detects or continues scenario
    /// 3. Shows AI response with thinking delay
    /// 4. Requests and displays contextual ad
    func sendMessage() {
        let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        // Add user message
        let userText = trimmedText
        messages.append(MessageFactory.userMessage(userText))
        inputText = ""

        // Closure to request ad after AI response
        let showAdAfterReply: () -> Void = { [weak self] in
            self?.requestAdForContext(userText)
        }

        // Handle message based on scenario state
        processScenarioLogic(userText: userText, afterReply: showAdAfterReply)
    }

    /// Clears all messages and resets the chat state.
    func clearChat() {
        messages = []
        scenarioManager.reset()
        isThinking = false
        inputText = ""
    }

    /// Initializes the CeedAdsSDK.
    ///
    /// Should be called when the view appears.
    func initializeSDK() {
        do {
            try CeedAdsSDK.initialize(appId: testAppId)
        } catch {
            print("[CeedAdsIOSSample] SDK initialization failed: \(error)")
        }
    }

    // MARK: - Private Methods - Scenario Logic

    /// Processes the user message through scenario detection and progression.
    /// - Parameters:
    ///   - userText: The user's input text
    ///   - afterReply: Closure to execute after AI reply (typically ad request)
    private func processScenarioLogic(userText: String, afterReply: @escaping () -> Void) {
        // Case 1: No active scenario - try to detect one
        if !scenarioManager.hasActiveScenario {
            handleNewScenarioDetection(userText: userText, afterReply: afterReply)
            return
        }

        // Case 2: Scenario is finished
        if scenarioManager.isScenarioFinished {
            showThinkingThenReply(text: scenarioCompleteMessage, afterReply: afterReply)
            return
        }

        // Case 3: Continue active scenario
        if let nextAIMessage = scenarioManager.nextAIMessage() {
            showThinkingThenReply(text: nextAIMessage, afterReply: afterReply)
        }
    }

    /// Handles scenario detection for a new conversation.
    /// - Parameters:
    ///   - userText: The user's input text
    ///   - afterReply: Closure to execute after AI reply
    private func handleNewScenarioDetection(userText: String, afterReply: @escaping () -> Void) {
        let detected = scenarioManager.detectScenario(from: userText)

        if detected == nil {
            // No scenario matched - show fallback
            showThinkingThenReply(text: fallbackMessage, afterReply: afterReply)
            return
        }

        // Start the detected scenario
        scenarioManager.startScenario(detected!)

        if let firstAIMessage = scenarioManager.nextAIMessage() {
            showThinkingThenReply(text: firstAIMessage, afterReply: afterReply)
        }
    }

    // MARK: - Private Methods - UI State

    /// Shows a thinking indicator, then displays the AI reply after a delay.
    /// - Parameters:
    ///   - text: The AI response text
    ///   - afterReply: Closure to execute after reply is shown
    private func showThinkingThenReply(text: String, afterReply: @escaping () -> Void) {
        isThinking = true
        let delay = DesignSystem.Animation.randomResponseDelay

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.isThinking = false
            self?.messages.append(MessageFactory.aiMessage(text))
            afterReply()
        }
    }

    // MARK: - Private Methods - Ad Request

    /// Requests a contextual ad based on the conversation context.
    /// - Parameter contextText: The text to use for ad matching
    private func requestAdForContext(_ contextText: String) {
        // Get recommended formats for current scenario
        let formats = recommendedFormats(for: scenarioManager.currentScenario)

        requestAd(
            conversationId: demoConversationId,
            messageId: UUID().uuidString,
            contextText: contextText,
            formats: formats
        ) { [weak self] ad, requestId in
            if let ad = ad {
                self?.messages.append(MessageFactory.adMessage(ad, requestId: requestId))
            }
        }
    }

    /// Returns recommended ad formats for a given scenario.
    ///
    /// This helper maps scenarios to their ideal ad formats:
    /// - Original scenarios (english, programming, travel) → action_card
    /// - leadGen scenario → lead_gen (email capture)
    /// - staticAd scenario → static (banner display)
    /// - followup scenario → followup (engagement card)
    ///
    /// - Parameter scenario: The current scenario type
    /// - Returns: Array of recommended AdFormat values, or nil for all formats
    ///
    /// ## Example Usage
    /// ```swift
    /// let formats = recommendedFormats(for: .leadGen)
    /// // Returns [.leadGen] for email capture scenarios
    ///
    /// let formats = recommendedFormats(for: .english)
    /// // Returns [.actionCard] for traditional CTA scenarios
    ///
    /// let formats = recommendedFormats(for: nil)
    /// // Returns nil to request all available formats
    /// ```
    private func recommendedFormats(for scenario: ScenarioType?) -> [AdFormat]? {
        guard let scenario = scenario else {
            // No active scenario - request all formats
            return nil
        }

        switch scenario {
        // Original scenarios: Traditional action card ads
        case .english, .programming, .programmingJa, .travel:
            return [.actionCard]

        // Format-specific scenarios
        case .leadGen:
            return [.leadGen]

        case .staticAd:
            return [.staticAd]

        case .followup:
            return [.followup]
        }
    }

    /// Makes an ad request to the CeedAdsSDK.
    ///
    /// - Parameters:
    ///   - conversationId: Unique conversation identifier
    ///   - messageId: Unique message identifier
    ///   - contextText: Text for contextual matching
    ///   - formats: Preferred ad formats (nil for all formats)
    ///   - completion: Callback with ad result (called on main thread)
    ///
    /// ## Formats Parameter
    ///
    /// The `formats` parameter allows filtering which ad formats to request:
    ///
    /// | Value               | Description                           |
    /// |---------------------|---------------------------------------|
    /// | `nil`               | Request all available formats         |
    /// | `[.actionCard]`     | Only traditional CTA cards            |
    /// | `[.leadGen]`        | Only email capture forms              |
    /// | `[.staticAd]`       | Only banner-style displays            |
    /// | `[.followup]`       | Only engagement cards with options    |
    /// | `[.actionCard, .leadGen]` | Multiple formats allowed        |
    ///
    /// - Note: The SDK now supports formats parameter server-side filtering.
    private func requestAd(
        conversationId: String,
        messageId: String,
        contextText: String,
        formats: [AdFormat]? = nil,
        completion: @escaping (ResolvedAd?, String?) -> Void
    ) {
        // Log format preference for debugging
        if let formats = formats {
            let formatNames = formats.map { $0.rawValue }.joined(separator: ", ")
            print("[CeedAdsIOSSample] Requesting ad with formats: [\(formatNames)]")
        } else {
            print("[CeedAdsIOSSample] Requesting ad with all formats")
        }

        Task {
            do {
                let (ad, requestId) = try await CeedAdsSDK.requestAd(
                    conversationId: conversationId,
                    messageId: messageId,
                    contextText: contextText,
                    formats: formats
                )
                await MainActor.run {
                    completion(ad, requestId)
                }
            } catch {
                print("[CeedAdsIOSSample] requestAd failed: \(error)")
                await MainActor.run {
                    completion(nil, nil)
                }
            }
        }
    }
}
