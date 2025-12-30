//
//  FeedFeatureAPIClient.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public final class FeedFeatureAPIClient: FeedFeatureAPI {
    
    private let bffBase = "https://jsonplaceholder.typicode.com"

    public let networking: Networking

    public init(networking: Networking) {
        self.networking = networking
    }
    
    public func fetchFeeds() async throws -> [Post]? {
        let url = "\(bffBase)/posts"

        let posts = try await networking.fetchList(
            url: url,
            type: Post.self
        )
        
        return posts
    }
    
    public func updatePost(_ post: Post) async throws -> Post? {
        let url = URL(string: "\(bffBase)/posts/\(post.id)")!

        let result = try await networking.updateRecord(
            url: url,
            type: Post.self,
            record: post
        )
        
        return result
    }
    
    public func deletePost(_ post: Post) async throws {
        let url = URL(string: "\(bffBase)/posts")!

        if let id = post.id as? Int {
            return try await networking.deleteRecord(
                url: url,
                type: Post.self,
                withID: id
            )
        }
    }
}
