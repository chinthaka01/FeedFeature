//
//  FeedFeatureAPIClient.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public class FeedFeatureAPIClient: FeedFeatureAPI {
    public init() {}
    
    public func fetchFeeds() async throws -> any FeedDTO {
        return FeedDTOImpl()
    }
}
