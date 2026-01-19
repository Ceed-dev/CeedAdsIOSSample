//
//  ChatView.swift
//  CeedAdsIOSSample
//
//  Demo chat simulator that demonstrates Ceed Ads SDK integration.
//  This mirrors the logic from the Web SDK test page.
//

import SwiftUI
import CeedAdsSDK

struct ChatView: View {
    // MARK: - Properties

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
                Button(action: viewModel.clearChat) {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
        .onAppear {
            viewModel.initializeSDK()
        }
    }

    // MARK: - Subviews

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

    private var emptyStateView: some View {
        Text("Chat will appear here...")
            .foregroundColor(Color(.secondaryLabel))
            .padding(.top, DesignSystem.Spacing.xl)
    }

    @ViewBuilder
    private func messageView(for message: Message) -> some View {
        switch message.role {
        case .user, .ai:
            MessageBubbleView(message: message)
        case .ad:
            if let ad = message.ad {
                CeedAdsActionCardView(ad: ad, requestId: message.requestId)
                    .padding(.horizontal)
            } else {
                EmptyView()
            }
        }
    }

    private var inputBar: some View {
        HStack(spacing: DesignSystem.Spacing.md) {
            TextField("Type a message...", text: $viewModel.inputText)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    viewModel.sendMessage()
                }

            Button(action: viewModel.sendMessage) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(DesignSystem.Size.sendButtonPadding)
                    .background(viewModel.inputText.isEmpty ? Color.gray : Color.blue)
                    .clipShape(Circle())
            }
            .disabled(viewModel.inputText.isEmpty)
        }
        .padding()
    }

    // MARK: - Helpers

    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let lastMessage = viewModel.messages.last {
            withAnimation {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
