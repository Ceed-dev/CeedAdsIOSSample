# CeedAdsIOSSample

A sample iOS application demonstrating the integration of the Ceed Ads iOS SDK. This app provides a chat-based interface to test and showcase how contextual ads are displayed within conversational AI experiences.

## Overview

CeedAdsIOSSample is a test application for the [ceed-ads-ios-sdk](https://github.com/example/ceed-ads-ios-sdk). It simulates a conversational AI assistant that can discuss various topics, and displays relevant ads based on the conversation context.

The app features predefined conversation scenarios that demonstrate how ads are matched and displayed in response to user interactions.

## Requirements

- iOS 26.2+
- Xcode 16.0+
- Swift 5.0+
- [CeedAdsSDK](https://github.com/example/ceed-ads-ios-sdk) package

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/example/CeedAdsIOSSample.git
   cd CeedAdsIOSSample
   ```

2. Open the project in Xcode:
   ```bash
   open CeedAdsIOSSample.xcodeproj
   ```

3. Resolve Swift Package dependencies:
   - Xcode will automatically fetch the CeedAdsSDK package
   - If not, go to File > Packages > Resolve Package Versions

4. Build and run on a simulator or device

## Usage

### Testing Ad Display

1. **Launch the app** - A chat interface will appear
2. **Start a conversation** - Type a message that triggers one of the predefined scenarios
3. **Follow the conversation** - The AI will guide you through a multi-turn dialogue
4. **Observe ad placement** - After AI responses, contextual ads appear based on the conversation topic

### Triggering Scenarios

The app includes three demonstration scenarios, each triggered by specific keywords:

| Scenario | Trigger Keywords | Ad Context |
|----------|-----------------|------------|
| English Learning | "communicating", "another", "language" | Language learning apps |
| Programming | "tech" | Coding courses |
| Travel Planning | "off", "places", "refreshing" | Hotels, travel services |

**Tip**: If no keywords are detected, the app defaults to the Japanese programming scenario.

### Example Conversation

```
You: I'm thinking about getting into tech
AI: A good entry point is understanding basic problem-solving...
You: Should I focus on concepts or building?
AI: Starting with small hands-on exercises works well...
[... conversation continues ...]
You: Do you know any good AI coding course?
AI: Let me take a look...
[Ad appears: Relevant coding course recommendation]
```

### Controls

- **Send Message**: Type in the text field and tap the send button (or press return)
- **Clear Chat**: Tap the refresh icon in the navigation bar to reset the conversation

## Architecture

```
CeedAdsIOSSample/
├── CeedAdsIOSSampleApp.swift   # App entry point
├── ContentView.swift            # Root view with NavigationStack
├── ChatView.swift               # Main chat interface
├── ChatViewModel.swift          # Business logic & SDK integration
├── Message.swift                # Message data model
├── MessageBubbleView.swift      # Chat bubble UI component
├── MessageFactory.swift         # Message creation helpers
├── ScenarioData.swift           # Predefined conversation scenarios
├── ScenarioManager.swift        # Scenario state management
├── TypingIndicatorView.swift    # Animated typing indicator
└── DesignSystem.swift           # Design tokens & constants
```

## SDK Integration Points

The app demonstrates key SDK integration patterns:

1. **Initialization** (`ChatViewModel.initializeSDK()`):
   ```swift
   try CeedAdsSDK.initialize(appId: "test-app")
   ```

2. **Ad Request** (`ChatViewModel.requestAd()`):
   ```swift
   let (ad, requestId) = try await CeedAdsSDK.requestAd(
       conversationId: "demo-conv",
       messageId: UUID().uuidString,
       contextText: userText
   )
   ```

3. **Ad Display** (`ChatView.messageView()`):
   ```swift
   CeedAdsActionCardView(ad: ad, requestId: message.requestId)
   ```

## License

This project is proprietary software. All rights reserved.
