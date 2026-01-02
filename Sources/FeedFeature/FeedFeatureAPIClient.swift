//
//  FeedFeatureAPIClient.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public final class FeedFeatureAPIClient: FeedFeatureAPI {
    public let networking: Networking
    private let bffPath = "posts"

    public init(networking: Networking) {
        self.networking = networking
    }
    
    public func fetchFeeds() async throws -> [Post] {
        let posts = try await networking.fetchList(
            bffPath: bffPath,
            type: Post.self
        )
        
        return posts
    }
    
    public func updatePost(_ post: Post) async throws -> Post {
        let result = try await networking.updateRecord(
            bffPath: "/posts/\(post.id)",
            type: Post.self,
            record: post
        )
        
        return result
    }
    
    public func deletePost(_ post: Post) async throws {
        return try await networking.deleteRecord(
            bffPath: bffPath,
            type: Post.self,
            withID: post.id
        )
    }
}
