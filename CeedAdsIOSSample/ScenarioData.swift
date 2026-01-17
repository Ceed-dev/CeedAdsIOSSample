//
//  ScenarioData.swift
//  CeedAdsIOSSample
//
//  Scenario definitions for the demo chat simulator.
//  These mirror the Web SDK test page scenarios.
//

import Foundation

/// A single dialogue entry in a scenario (alternating user/ai)
struct ScenarioMessage {
    let role: MessageRole
    let text: String
}

/// Scenario type enumeration
enum ScenarioType: String {
    case english
    case programming
    case programmingJa
    case travel
}

/// Keywords that trigger each scenario
struct ScenarioKeyword {
    let scenario: ScenarioType
    let keywords: [String]
}

/// Scenario detection keywords
/// Matches the Web version's scenarioKeywords
let scenarioDetectionKeywords: [ScenarioKeyword] = [
    ScenarioKeyword(scenario: .english, keywords: ["communicating", "another", "language"]),
    ScenarioKeyword(scenario: .programming, keywords: ["tech"]),
    ScenarioKeyword(scenario: .travel, keywords: ["off", "places", "refreshing"]),
]

// ============================================================================
// English Learning Scenario
// ============================================================================
// The final user message includes keywords such as "AI", "English", and
// "conversation" to trigger ad matching.

let englishScenario: [ScenarioMessage] = [
    ScenarioMessage(role: .user, text: "I want to get better at communicating in another language. Where should I begin?"),
    ScenarioMessage(role: .ai, text: "A good start is to build daily speaking habits. Even short self-talk or reading aloud helps."),
    ScenarioMessage(role: .user, text: "How can I check whether my pronunciation sounds natural?"),
    ScenarioMessage(role: .ai, text: "Recording your voice and comparing it with native speakers is very effective."),
    ScenarioMessage(role: .user, text: "I often forget new words I try to memorize. Any tips?"),
    ScenarioMessage(role: .ai, text: "Using spaced repetition is helpful. Simple flashcards can improve long-term memory."),
    ScenarioMessage(role: .user, text: "I also want to practice more natural interactions."),
    ScenarioMessage(role: .ai, text: "Role-playing everyday scenes is a great way to build confidence and fluency."),
    ScenarioMessage(role: .user, text: "Is there any good AI English conversation app you recommend?"),
    ScenarioMessage(role: .ai, text: "There are several options. Let me check what might suit your learning style."),
]

// ============================================================================
// Programming Learning Scenario (English)
// ============================================================================
// The final user message includes keywords such as "AI", "coding", and
// "course" to trigger ad matching.

let programmingScenario: [ScenarioMessage] = [
    ScenarioMessage(role: .user, text: "I'm thinking about getting into tech, but I'm not sure where to start. Any suggestions?"),
    ScenarioMessage(role: .ai, text: "A good entry point is understanding basic problem-solving and logic. Many beginners start with simple tasks to build confidence."),
    ScenarioMessage(role: .user, text: "Should I focus more on understanding concepts first or try building something right away?"),
    ScenarioMessage(role: .ai, text: "Starting with small hands-on exercises works well. You can pick up the ideas behind them naturally over time."),
    ScenarioMessage(role: .user, text: "I sometimes lose motivation when things get too difficult. Any advice?"),
    ScenarioMessage(role: .ai, text: "Setting small, clear goals helps. Even completing one simple task a day creates steady progress."),
    ScenarioMessage(role: .user, text: "What about fixing mistakes? I get stuck pretty easily."),
    ScenarioMessage(role: .ai, text: "Breaking problems down and checking each part step by step usually helps reveal what's going wrong."),
    ScenarioMessage(role: .user, text: "Do you know any good AI coding course that can help me learn faster?"),
    ScenarioMessage(role: .ai, text: "There are a few options depending on your learning style. Let me take a look."),
]

// ============================================================================
// Programming Learning Scenario (Japanese)
// ============================================================================
// The final user message includes keywords such as "AI", "coding", and
// "course" to trigger ad matching.

let programmingScenarioJa: [ScenarioMessage] = [
    ScenarioMessage(role: .user, text: "テック業界に興味があるのですが、どこから始めればいいのか分かりません。何かアドバイスはありますか？"),
    ScenarioMessage(role: .ai, text: "まずは基本的な問題解決力やロジックを理解することが良い入口になります。多くの初心者は、簡単な課題から始めて自信をつけています。"),
    ScenarioMessage(role: .user, text: "最初は概念の理解を重視したほうがいいですか？それとも、すぐに何か作ってみるべきでしょうか？"),
    ScenarioMessage(role: .ai, text: "小さなハンズオンの練習から始めるのがおすすめです。実際に手を動かしながら、自然と考え方を身につけられます。"),
    ScenarioMessage(role: .user, text: "難しくなると、モチベーションが下がってしまうことがあります。何か良い対処法はありますか？"),
    ScenarioMessage(role: .ai, text: "小さくて明確な目標を設定することが大切です。1日に1つ簡単なタスクを終えるだけでも、着実な前進になります。"),
    ScenarioMessage(role: .user, text: "ミスを修正するときに詰まってしまいます。どうすればいいでしょうか？"),
    ScenarioMessage(role: .ai, text: "問題を細かく分解して、一つずつ確認していくと、原因が見えてくることが多いです。"),
    ScenarioMessage(role: .user, text: "学習を早く進められる、良いAIコーディングコースを知っていますか？"),
    ScenarioMessage(role: .ai, text: "学習スタイルによっていくつか選択肢があります。少し調べてみますね。"),
]

// ============================================================================
// Travel Planning Scenario
// ============================================================================
// The final user message includes keywords such as "nice" and "hotel"
// to trigger ad matching.

let travelScenario: [ScenarioMessage] = [
    ScenarioMessage(role: .user, text: "I'm thinking about taking some time off soon. Any ideas for places that might be refreshing?"),
    ScenarioMessage(role: .ai, text: "It depends on the atmosphere you enjoy. Do you prefer quiet places, lively areas, or somewhere close to nature?"),
    ScenarioMessage(role: .user, text: "I want somewhere calm but still interesting. Ideally somewhere warm."),
    ScenarioMessage(role: .ai, text: "In that case, regions with mild climates could be a good fit. Many people enjoy spots where they can unwind but also explore a bit."),
    ScenarioMessage(role: .user, text: "I haven't really traveled much, so I'm open to new places. When is a good season to go somewhere warm?"),
    ScenarioMessage(role: .ai, text: "Late spring or early autumn tends to be comfortable in many destinations—pleasant weather and not too crowded."),
    ScenarioMessage(role: .user, text: "That sounds nice. I think I'll pick a warm coastal area then."),
    ScenarioMessage(role: .ai, text: "Great. Are your dates already decided, or are you still thinking about it?"),
    ScenarioMessage(role: .user, text: "Do you know any nice hotel around there?"),
    ScenarioMessage(role: .ai, text: "There are several options depending on your budget and style. Let me check what might be a good fit."),
]

/// Lookup table for scenarios
let scenarioTable: [ScenarioType: [ScenarioMessage]] = [
    .english: englishScenario,
    .programming: programmingScenario,
    .programmingJa: programmingScenarioJa,
    .travel: travelScenario,
]

