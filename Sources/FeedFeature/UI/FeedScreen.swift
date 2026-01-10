//
//  File.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import SwiftUI
import PlatformKit
import DesignSystem

/// Main feed list screen for the Feed feature.
///
/// Renders loading, error, empty, and content states using the shared
/// `FeedViewModel` and design system components.
struct FeedScreen: View {
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading feed…")
            } else if let error = viewModel.error {
                errorView(error)
            } else if viewModel.posts.isEmpty {
                emptyView()
            } else {
                ScrollView {
                    LazyVStack(spacing: DSSpacing.md) {
                        ForEach(viewModel.posts) { post in
                            PostCard(post: post)
                        }
                    }
                    .padding(.vertical, DSSpacing.md)
                }
            }
        }
        .navigationTitle("Feeds")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.default, value: viewModel.posts)
        .task {
            await viewModel.loadFeed()
        }
        .refreshable {
            await viewModel.loadFeed()
        }
    }
}

struct PostCard: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: DSSpacing.sm) {
            HStack(alignment: .top, spacing: DSSpacing.md) {
                DSAvatar(name: "\(post.userId)")

                VStack(alignment: .leading, spacing: 4) {
                    Text("User \(post.userId)")
                        .font(DSTextStyle.caption)
                        .foregroundColor(DSColor.secondaryText)

                    Text(post.title)
                        .font(DSTextStyle.headline)
                        .foregroundColor(DSColor.secondaryText)
                }

                Spacer()
            }

            Text(post.body)
                .font(DSTextStyle.body)
                .foregroundColor(DSColor.secondaryText)
                .fixedSize(horizontal: false, vertical: true)

        }
        .padding(DSSpacing.md)
        .background(DSColor.card)
        .cornerRadius(16)
        .padding(.horizontal, DSSpacing.md)
    }
}

private extension FeedScreen {
    func errorView(_ error: Error) -> some View {
        ContentUnavailableView {
            Label("Unable to Load Feeds", systemImage: "exclamationmark.triangle.fill")
        } description: {
            Text(viewModel.error?.localizedDescription ?? "")
                .font(DSTextStyle.body)
        } actions: {
            DSButton(title: "Retry", icon: "arrow.counterclockwise") {
                Task {
                    await viewModel.loadFeed()
                }
            }
        }
    }
}

private extension FeedScreen {
    func emptyView() -> some View {
        ContentUnavailableView {
            Label("Feed is empty", systemImage: "house")
        } description: {
            Text("You don’t have any posts in your feed yet.")
                .font(DSTextStyle.body)
        } actions: {
            DSButton(title: "Retry", icon: "arrow.counterclockwise") {
                Task {
                    await viewModel.loadFeed()
                }
            }
        }
    }
}
