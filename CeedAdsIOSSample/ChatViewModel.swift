//
//  ChatViewModel.swift
//  CeedAdsIOSSample
//
//  ViewModel for ChatView that handles all business logic.
//

import Foundation
import SwiftUI

@Observable
final class ChatViewModel {
    // MARK: - Properties

    private(set) var messages: [Message] = []
    var inputText: String = ""
    private(set) var isThinking: Bool = false

    private let scenarioManager = ScenarioManager()

    // MARK: - Public Methods

    /// Send the current input message
    func sendMessage() {
        let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        let userText = trimmedText
        messages.append(MessageFactory.userMessage(userText))
        inputText = ""

        // Closure to request ad after AI response
        let showAdAfterReply: () -> Void = { [weak self] in
            guard let self else { return }
            self.requestAd(
                conversationId: "demo-conv",
                messageId: UUID().uuidString,
                contextText: userText
            ) { [weak self] ad, requestId in
                if let ad = ad {
                    self?.messages.append(MessageFactory.adMessage(ad, requestId: requestId))
                }
            }
        }

        // Scenario detection logic
        if !scenarioManager.hasActiveScenario {
            let detected = scenarioManager.detectScenario(from: userText)

            if detected == nil {
                // No scenario detected - show fallback
                showThinkingThenReply(
                    text: "I can assist with English learning, programming, or travel planning. Which one are you interested in?",
                    afterReply: showAdAfterReply
                )
                return
            }

            // Start new scenario
            scenarioManager.startScenario(detected!)

            guard let firstAIMessage = scenarioManager.nextAIMessage() else { return }

            showThinkingThenReply(text: firstAIMessage, afterReply: showAdAfterReply)
            return
        }

        // Scenario is active - continue progression
        if scenarioManager.isScenarioFinished {
            showThinkingThenReply(
                text: "Thanks! Let me know if you need anything else.",
                afterReply: showAdAfterReply
            )
            return
        }

        // Get next AI response in scenario
        guard let nextAIMessage = scenarioManager.nextAIMessage() else { return }

        showThinkingThenReply(text: nextAIMessage, afterReply: showAdAfterReply)
    }

    /// Clear the chat and reset state
    func clearChat() {
        messages = []
        scenarioManager.reset()
        isThinking = false
        inputText = ""
    }

    /// Initialize the SDK (called on view appear)
    func initializeSDK() {
        print("⭐ SDK: initialize(appId: \"test-app\")")
        // TODO(shungo): Replace with actual SDK call
        // CeedAds.initialize(appId: "test-app")
    }

    // MARK: - Private Methods

    private func showThinkingThenReply(text: String, afterReply: @escaping () -> Void) {
        isThinking = true
        let delay = DesignSystem.Animation.randomResponseDelay

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.isThinking = false
            self?.messages.append(MessageFactory.aiMessage(text))
            afterReply()
        }
    }

    private func requestAd(
        conversationId: String,
        messageId: String,
        contextText: String,
        completion: @escaping (ResolvedAd?, String?) -> Void
    ) {
        print("⭐ SDK: requestAd(conversationId: \"\(conversationId)\", messageId: \"\(messageId)\", contextText: \"\(contextText)\")")

        // TODO(shungo): Replace with actual SDK call
        // CeedAds.requestAd(
        //     conversationId: conversationId,
        //     messageId: messageId,
        //     contextText: contextText
        // ) { result in
        //     completion(result.ad, result.requestId)
        // }

        // For now: no ads (will be enabled when SDK is integrated)
        completion(nil, nil)
    }
}
