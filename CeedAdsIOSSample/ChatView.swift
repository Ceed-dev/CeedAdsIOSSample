//
//  ChatView.swift
//  CeedAdsIOSSample
//
//  Demo chat simulator that demonstrates Ceed Ads SDK integration.
//  This mirrors the logic from the Web SDK test page.
//

import SwiftUI
import CeedAdsSDK

// MARK: - ChatView

/// The main chat interface view that displays conversation messages and ads.
///
/// This view provides:
/// - A scrollable list of chat messages (user, AI, and ads)
/// - A text input bar for sending messages
/// - Automatic scrolling to the latest message
/// - Integration with CeedAdsSDK for displaying contextual ads
struct ChatView: View {

    // MARK: - Properties

    /// ViewModel that manages chat state and business logic
    @State private var viewModel = ChatViewModel()

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            messageList
            Divider()
            inputBar
        }
        .navigationTitle("Chat")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                clearButton
            }
        }
        .onAppear {
            viewModel.initializeSDK()
        }
    }

    // MARK: - Toolbar Items

    /// Button to clear the chat history
    private var clearButton: some View {
        Button(action: viewModel.clearChat) {
            Image(systemName: "arrow.counterclockwise")
        }
    }

    // MARK: - Message List

    /// Scrollable list of all chat messages
    private var messageList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: DesignSystem.Spacing.sm) {
                    if viewModel.messages.isEmpty {
                        emptyStateView
                    }

                    ForEach(viewModel.messages) { message in
                        messageView(for: message)
                            .id(message.id)
                    }

                    if viewModel.isThinking {
                        TypingIndicatorView()
                    }
                }
                .padding(.vertical)
            }
            .onChange(of: viewModel.messages.count) {
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: viewModel.isThinking) {
                scrollToBottom(proxy: proxy)
            }
        }
    }

    /// Placeholder view shown when chat is empty
    private var emptyStateView: some View {
        Text("Chat will appear here...")
            .foregroundColor(Color(.secondaryLabel))
            .padding(.top, DesignSystem.Spacing.xl)
    }

    // MARK: - Message Views

    /// Renders the appropriate view for a given message based on its role
    /// - Parameter message: The message to display
    /// - Returns: A view representing the message (bubble, ad card, etc.)
    @ViewBuilder
    private func messageView(for message: Message) -> some View {
        switch message.role {
        case .user, .ai:
            MessageBubbleView(message: message)

        case .ad:
            adView(for: message)
        }
    }

    /// Renders an ad view for ad-type messages
    /// - Parameter message: The message containing ad data
    /// - Returns: A CeedAdsView or EmptyView if no ad data exists
    @ViewBuilder
    private func adView(for message: Message) -> some View {
        if let ad = message.ad {
            CeedAdsView(
                ad: ad,
                requestId: message.requestId,
                onLeadGenSubmit: { email in
                    print("[CeedAdsIOSSample] Lead submitted: \(email)")
                },
                onFollowupOptionSelected: { option in
                    print("[CeedAdsIOSSample] Option selected: \(option.label)")
                }
            )
            .padding(.horizontal)
        } else {
            EmptyView()
        }
    }

    // MARK: - Input Bar

    /// Text input field and send button
    private var inputBar: some View {
        HStack(spacing: DesignSystem.Spacing.md) {
            textField
            sendButton
        }
        .padding()
    }

    /// Text field for message input
    private var textField: some View {
        TextField("Type a message...", text: $viewModel.inputText)
            .textFieldStyle(.roundedBorder)
            .onSubmit {
                viewModel.sendMessage()
            }
    }

    /// Circular send button
    private var sendButton: some View {
        Button(action: viewModel.sendMessage) {
            Image(systemName: "paperplane.fill")
                .foregroundColor(.white)
                .padding(DesignSystem.Size.sendButtonPadding)
                .background(viewModel.inputText.isEmpty ? Color.gray : Color.blue)
                .clipShape(Circle())
        }
        .disabled(viewModel.inputText.isEmpty)
    }

    // MARK: - Helpers

    /// Scrolls the message list to show the latest message
    /// - Parameter proxy: The ScrollViewProxy for programmatic scrolling
    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let lastMessage = viewModel.messages.last {
            withAnimation {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ChatView()
    }
}
