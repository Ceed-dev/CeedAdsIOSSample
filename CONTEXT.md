# CeedAdsIOSSample - Development Context

This document provides context for AI assistants and developers working on this project.

## Purpose

CeedAdsIOSSample serves as:

1. **SDK Test Application**: Primary test bed for validating [ceed-ads-ios-sdk](https://github.com/example/ceed-ads-ios-sdk) functionality
2. **Integration Reference**: Demonstrates best practices for SDK integration in SwiftUI apps
3. **Demo Tool**: Showcases ad delivery in conversational AI contexts to stakeholders

## Relationship with ceed-ads-ios-sdk

This sample app depends on the CeedAdsSDK Swift package. The SDK provides:

- `CeedAdsSDK.initialize(appId:)` - SDK initialization
- `CeedAdsSDK.requestAd(conversationId:messageId:contextText:)` - Ad request API
- `ResolvedAd` - Ad data model with format-specific configurations
- `CeedAdsView` - Unified view that auto-selects the appropriate format
- `CeedAdsActionCardView` - Traditional action card display
- `CeedAdsLeadGenView` - Email capture form
- `CeedAdsStaticView` - Banner-style display
- `CeedAdsFollowupView` - Engagement card with selectable options

**Important**: The SDK is a separate package. Changes to ad logic, ad formats, or API endpoints are made in the SDK repository, not here.

## Testable Features

### Currently Implemented

| Feature | Status | Notes |
|---------|--------|-------|
| SDK Initialization | ✅ | `test-app` ID for testing |
| Ad Request (Text Context) | ✅ | Uses conversation text as context |
| Action Card Display | ✅ | Uses `CeedAdsView` (unified) |
| Lead Gen Display | ✅ | Email capture form with validation |
| Static Ad Display | ✅ | Banner-style with optional image |
| Followup Display | ✅ | Selectable options with feedback |
| Multi-turn Conversation | ✅ | 7 scenario types available |
| Typing Indicator | ✅ | Animated dots |
| Dark Mode Support | ✅ | Adaptive colors (dark theme default) |

### Ad Format Test Scenarios

| Format | Trigger Keywords | Purpose |
|--------|-----------------|---------|
| Action Card | "tech", "language", etc. | Traditional CTA cards |
| Lead Gen | "newsletter", "subscribe", "updates" | Email capture testing |
| Static | "event", "promotion", "deal" | Banner display testing |
| Followup | "feedback", "survey", "opinion" | Option selection testing |

### Planned / Future Features

| Feature | Status | Notes |
|---------|--------|-------|
| Video Ads | Under consideration | Not yet in SDK |
| Native Ads | Under consideration | Not yet in SDK |

## Conversation Scenarios

The app uses predefined scenarios (see `ScenarioData.swift`) to ensure consistent testing:

### Original Scenarios (Action Card Format)

#### English Learning Scenario
- **Trigger**: Keywords like "communicating", "another", "language"
- **Purpose**: Tests ad matching for language learning products
- **Final context**: "AI English conversation app"

#### Programming Scenario (English)
- **Trigger**: Keyword "tech"
- **Purpose**: Tests ad matching for coding courses
- **Final context**: "AI coding course"

#### Programming Scenario (Japanese)
- **Trigger**: Default fallback (no English keywords detected)
- **Purpose**: Tests Japanese language ad matching
- **Final context**: Same as English but in Japanese

#### Travel Planning Scenario
- **Trigger**: Keywords like "off", "places", "refreshing"
- **Purpose**: Tests ad matching for travel services
- **Final context**: "nice hotel"

### New Format Test Scenarios

#### Lead Generation Scenario
- **Trigger**: "newsletter", "subscribe", "updates"
- **Purpose**: Tests lead_gen format with email capture
- **Expected Ad Format**: `CeedAdsLeadGenView`
- **Events Tested**: impression, submit

#### Static Ad Scenario
- **Trigger**: "event", "promotion", "deal"
- **Purpose**: Tests static format with banner display
- **Expected Ad Format**: `CeedAdsStaticView`
- **Events Tested**: impression, click

#### Followup Scenario
- **Trigger**: "feedback", "survey", "opinion"
- **Purpose**: Tests followup format with selectable options
- **Expected Ad Format**: `CeedAdsFollowupView`
- **Events Tested**: impression, optionTap

## Key Implementation Decisions

### Why Predefined Scenarios?

Rather than free-form conversation, we use scenarios because:
- **Reproducibility**: Same input always produces same conversation flow
- **Testing**: Easier to verify ad matching with known final context
- **Demo reliability**: Stakeholder demos work consistently

### Why SwiftUI?

- Modern iOS development standard
- Better support for reactive UI updates
- Cleaner integration with async/await patterns

### Why @Observable (iOS 17+)?

- Simpler than ObservableObject + @Published
- Better performance (fine-grained updates)
- Cleaner syntax

## Developer Notes

### Adding a New Scenario

1. Define the scenario messages in `ScenarioData.swift`:
   ```swift
   let newScenario: [ScenarioMessage] = [
       ScenarioMessage(role: .user, text: "..."),
       ScenarioMessage(role: .ai, text: "..."),
       // ... alternating user/ai messages
   ]
   ```

2. Add to `ScenarioType` enum:
   ```swift
   enum ScenarioType: String {
       // ... existing cases
       case newScenario
   }
   ```

3. Add trigger keywords in `scenarioDetectionKeywords`:
   ```swift
   ScenarioKeyword(scenario: .newScenario, keywords: ["trigger", "words"]),
   ```

4. Register in `scenarioTable`:
   ```swift
   .newScenario: newScenario,
   ```

### Testing Different Ad Responses

The ad content returned depends on the backend ad server configuration. To test different ads:
- Modify the `contextText` parameter in ad requests
- Ensure backend has ads configured for the test context
- Check Network debugging for request/response details

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| No ads appearing | Backend not configured | Check ad server has test ads |
| SDK init failure | Invalid app ID | Use "test-app" for development |
| Scenario not triggering | Keywords not in message | Check `scenarioDetectionKeywords` |

## Session History

### 2026-01-31 (Update 2)
- Integrated new ad formats support using `CeedAdsView` (unified view)
- Added 3 new test scenarios: leadGen, staticAd, followup
- Updated ChatView to use unified view with callbacks
- Updated fallback message to include new scenario options

### 2026-01-31
- Created initial README.md and CONTEXT.md documentation
- Project structure documented for future development

### 2026-01-19
- Chat interface implemented with scenario-based conversations
- CeedAdsSDK integration completed
- Dark mode support added

### 2026-01-15
- Initial project creation
- Basic SwiftUI app scaffold
