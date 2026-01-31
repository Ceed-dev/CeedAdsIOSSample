//
//  ScenarioData.swift
//  CeedAdsIOSSample
//
//  Scenario definitions for the demo chat simulator.
//  These mirror the Web SDK test page scenarios.
//

import Foundation

// MARK: - Data Models

/// A single dialogue entry in a scenario (alternating user/ai messages).
struct ScenarioMessage {
    /// The role of who sends this message
    let role: MessageRole
    /// The message text content
    let text: String
}

/// Scenario type enumeration for categorizing demo conversations.
///
/// Scenarios are divided into two categories:
/// - Original scenarios: Test traditional action card ads
/// - Format test scenarios: Test new ad formats (lead_gen, static, followup)
enum ScenarioType: String {
    // MARK: Original Scenarios (Action Card)
    case english          // English learning conversation
    case programming      // Programming learning (English)
    case programmingJa    // Programming learning (Japanese)
    case travel           // Travel planning conversation

    // MARK: Format Test Scenarios
    case leadGen          // Tests lead generation ads
    case staticAd         // Tests static display ads
    case followup         // Tests followup engagement cards
}

/// Keywords that trigger a specific scenario.
struct ScenarioKeyword {
    /// The scenario type to activate
    let scenario: ScenarioType
    /// Keywords that trigger this scenario (case-insensitive matching)
    let keywords: [String]
}

// MARK: - Scenario Detection

/// Scenario detection keywords.
///
/// When user input contains any of these keywords, the corresponding
/// scenario is activated. Matching is case-insensitive.
let scenarioDetectionKeywords: [ScenarioKeyword] = [
    // Original scenarios
    ScenarioKeyword(scenario: .english, keywords: ["communicating", "another", "language"]),
    ScenarioKeyword(scenario: .programming, keywords: ["tech"]),
    ScenarioKeyword(scenario: .travel, keywords: ["off", "places", "refreshing"]),

    // Format test scenarios
    ScenarioKeyword(scenario: .leadGen, keywords: ["newsletter", "subscribe", "updates"]),
    ScenarioKeyword(scenario: .staticAd, keywords: ["event", "promotion", "deal"]),
    ScenarioKeyword(scenario: .followup, keywords: ["feedback", "survey", "opinion"]),
]

// MARK: - Original Scenarios

// MARK: English Learning Scenario

/// English learning conversation scenario.
///
/// - Trigger: Keywords like "communicating", "another", "language"
/// - Ad Context: Final message asks about "AI English conversation app"
/// - Expected Ad: Language learning app recommendations
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

// MARK: Programming Learning Scenario (English)

/// Programming learning conversation scenario (English version).
///
/// - Trigger: Keyword "tech"
/// - Ad Context: Final message asks about "AI coding course"
/// - Expected Ad: Coding course recommendations
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

// MARK: Programming Learning Scenario (Japanese)

/// Programming learning conversation scenario (Japanese version).
///
/// - Trigger: Default fallback when no English keywords match
/// - Ad Context: Final message asks about "AIコーディングコース"
/// - Expected Ad: Japanese coding course recommendations
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

// MARK: Travel Planning Scenario

/// Travel planning conversation scenario.
///
/// - Trigger: Keywords like "off", "places", "refreshing"
/// - Ad Context: Final message asks about "nice hotel"
/// - Expected Ad: Hotel and travel service recommendations
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

// MARK: - Format Test Scenarios

// MARK: Lead Generation Scenario

/// Lead generation ad format test scenario.
///
/// - Trigger: Keywords "newsletter", "subscribe", "updates"
/// - Ad Format: `lead_gen` (email capture form)
/// - Events Tested: impression, submit
let leadGenScenario: [ScenarioMessage] = [
    ScenarioMessage(role: .user, text: "I'd like to stay updated on the latest newsletter and industry trends."),
    ScenarioMessage(role: .ai, text: "That's great! Staying informed helps you make better decisions. Are you interested in any specific topics?"),
    ScenarioMessage(role: .user, text: "Mainly technology and business innovations."),
    ScenarioMessage(role: .ai, text: "Those are popular topics. Many professionals find curated newsletters save time compared to browsing multiple sources."),
    ScenarioMessage(role: .user, text: "Exactly. I don't have time to check every website."),
    ScenarioMessage(role: .ai, text: "Understandable. A good newsletter delivers key insights directly to your inbox."),
    ScenarioMessage(role: .user, text: "Can you recommend a way to subscribe to quality updates?"),
    ScenarioMessage(role: .ai, text: "Let me find some options for you."),
]

// MARK: Static Ad Scenario

/// Static ad format test scenario.
///
/// - Trigger: Keywords "event", "promotion", "deal"
/// - Ad Format: `static` (banner-style display)
/// - Events Tested: impression, click
let staticAdScenario: [ScenarioMessage] = [
    ScenarioMessage(role: .user, text: "I heard there's a big event coming up. Any promotion or deal I should know about?"),
    ScenarioMessage(role: .ai, text: "There are always interesting events and promotions happening. What kind of event are you looking for?"),
    ScenarioMessage(role: .user, text: "Something related to tech or startups would be great."),
    ScenarioMessage(role: .ai, text: "Tech conferences and startup events are popular this time of year. They often have early-bird discounts."),
    ScenarioMessage(role: .user, text: "That sounds interesting. Are there any online events too?"),
    ScenarioMessage(role: .ai, text: "Yes, many events now offer hybrid formats. You can attend virtually if the venue is too far."),
    ScenarioMessage(role: .user, text: "Perfect. Can you show me what's available?"),
    ScenarioMessage(role: .ai, text: "Let me check the current promotions for you."),
]

// MARK: Followup Engagement Scenario

/// Followup engagement ad format test scenario.
///
/// - Trigger: Keywords "feedback", "survey", "opinion"
/// - Ad Format: `followup` (selectable options card)
/// - Events Tested: impression, optionTap
let followupScenario: [ScenarioMessage] = [
    ScenarioMessage(role: .user, text: "I'd like to share my feedback about a product I recently used."),
    ScenarioMessage(role: .ai, text: "That's helpful! Feedback helps companies improve their products. What kind of product was it?"),
    ScenarioMessage(role: .user, text: "It was a productivity app. I have some opinions about its features."),
    ScenarioMessage(role: .ai, text: "Productivity apps benefit greatly from user feedback. Was it generally positive or did you find issues?"),
    ScenarioMessage(role: .user, text: "Mixed. Some features are great, but others need improvement."),
    ScenarioMessage(role: .ai, text: "That's valuable insight. Detailed feedback like yours helps prioritize development."),
    ScenarioMessage(role: .user, text: "Is there a survey or way to submit my opinion officially?"),
    ScenarioMessage(role: .ai, text: "Let me find an appropriate feedback channel for you."),
]

// MARK: - Scenario Lookup Table

/// Lookup table mapping scenario types to their message sequences.
///
/// Use this table to retrieve the conversation flow for any scenario type.
let scenarioTable: [ScenarioType: [ScenarioMessage]] = [
    // Original scenarios
    .english: englishScenario,
    .programming: programmingScenario,
    .programmingJa: programmingScenarioJa,
    .travel: travelScenario,

    // Format test scenarios
    .leadGen: leadGenScenario,
    .staticAd: staticAdScenario,
    .followup: followupScenario,
]
