//
//  FeedFeatureAPIClient.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

/// Concrete implementation of `FeedFeatureAPI` used by the Feed feature.
///
/// Talks to the BFF to load, update, and delete posts.
/// (update and delete not in use in this demo app.)
public final class FeedFeatureAPIClient: FeedFeatureAPI {
    
    /// Networking abstraction injected from the shell app.
    public let networking: Networking
    
    /// Base BFF path for posts‑related endpoints.
    private let bffPath = "posts"

    public init(networking: Networking) {
        self.networking = networking
    }
    
    /// Fetches all posts for the feed.
    public func fetchFeeds() async throws -> [Post] {
        let posts = try await networking.fetchList(
            bffPath: bffPath,
            type: Post.self
        )
        
        return posts
    }
    
    /// Updates a single post on the BFF and returns the updated model.
    public func updatePost(_ post: Post) async throws -> Post {
        let result = try await networking.updateRecord(
            bffPath: "\(bffPath)/\(post.id)",
            type: Post.self,
            record: post
        )
        
        return result
    }
    
    /// Deletes a single post on the BFF.
    public func deletePost(_ post: Post) async throws {
        return try await networking.deleteRecord(
            bffPath: bffPath,
            type: Post.self,
            withID: post.id
        )
    }
}
