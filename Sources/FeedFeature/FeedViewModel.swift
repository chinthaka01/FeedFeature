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
    
    @Published var posts: [Post]?

    init(api: FeedFeatureAPI, analytics: Analytics) {
        self.api = api
        self.analytics = analytics
    }
    
    func loadFeed() async {
        do {
            posts = try await api.fetchFeeds()
        } catch {
            print("Failed to load feeds: \(error)")
        }
    }
    
    func updatePost(_ post: Post) async {
        do {
            _ = try await api.updatePost(post)
        } catch {
            print("Failed to update post: \(error)")
        }
    }
    
    func deletePost(_ post: Post) async {
        do {
            _ = try await api.deletePost(post)
        } catch {
            print("Failed to delete post: \(error)")
        }
    }
}
