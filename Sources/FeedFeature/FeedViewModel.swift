//
//  File.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

@MainActor
class FeedViewModel: ObservableObject {
    let api: any FeedFeatureAPI
    let analytics: any Analytics
    
    @Published var posts: [Post] = []
    @Published var isLoading = true
    @Published var error: Error? = nil

    init(api: FeedFeatureAPI, analytics: Analytics) {
        self.api = api
        self.analytics = analytics
    }
    
    func loadFeed() async {
        posts = []
        error = nil
        isLoading = true

        do {
            var allPosts = try await api.fetchFeeds()
            allPosts.shuffle()

            posts = allPosts
            
            broadcastSelfPostsCount()
        } catch {
            print("Failed to load feeds: \(error)")
            self.error = error
        }
        
        isLoading = false
    }
    
    func updatePost(_ post: Post) async {
        do {
            _ = try await api.updatePost(post)
        } catch {
            print("Failed to update post: \(error)")
        }
        
        isLoading = false
    }
    
    func deletePost(_ post: Post) async {
        do {
            _ = try await api.deletePost(post)
        } catch {
            print("Failed to delete post: \(error)")
        }
        
        isLoading = false
    }

    private func broadcastSelfPostsCount() {
        let selfPosts = posts.filter { $0.userId == 1 }

        NotificationCenter.default.post(
            name: AppBroadcast.selfPostsCount,
            object: nil,
            userInfo: ["payload_count": selfPosts.count]
        )
    }
}
