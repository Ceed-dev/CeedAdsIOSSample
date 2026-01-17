//
//  ScenarioManager.swift
//  CeedAdsIOSSample
//
//  Manages scenario detection and progression for the chat simulator.
//

import Foundation

/// Manages scenario state and progression
final class ScenarioManager {
    /// Currently active scenario (nil = no scenario detected yet)
    private(set) var currentScenario: ScenarioType?

    /// Current index in the scenario dialogue
    private(set) var currentMessageIndex: Int = 0

    /// Detect which scenario matches the user's input text
    /// Returns .programmingJa as fallback (same as Web version)
    func detectScenario(from text: String) -> ScenarioType? {
        let lower = text.lowercased()

        for entry in scenarioDetectionKeywords {
            if entry.keywords.contains(where: { lower.contains($0) }) {
                return entry.scenario
            }
        }

        // Fallback: treat unmatched input as Japanese programming test
        return .programmingJa
    }

    /// Start a new scenario
    func startScenario(_ type: ScenarioType) {
        currentScenario = type
        currentMessageIndex = 0
    }

    /// Get the next AI message in the current scenario
    /// Returns nil if no scenario is active or scenario is finished
    func nextAIMessage() -> String? {
        guard let scenarioType = currentScenario,
              let scenario = scenarioTable[scenarioType] else {
            return nil
        }

        // The scenario alternates: user[0], ai[1], user[2], ai[3], ...
        // After processing user message at index N, AI response is at N+1
        let aiIndex = currentMessageIndex + 1

        guard aiIndex < scenario.count else {
            return nil
        }

        let aiMessage = scenario[aiIndex]
        currentMessageIndex += 2 // Move past both user and AI messages
        return aiMessage.text
    }

    /// Check if the scenario is finished
    var isScenarioFinished: Bool {
        guard let scenarioType = currentScenario,
              let scenario = scenarioTable[scenarioType] else {
            return true
        }
        return currentMessageIndex >= scenario.count
    }

    /// Check if a scenario is active
    var hasActiveScenario: Bool {
        currentScenario != nil
    }

    /// Reset to initial state
    func reset() {
        currentScenario = nil
        currentMessageIndex = 0
    }
}
