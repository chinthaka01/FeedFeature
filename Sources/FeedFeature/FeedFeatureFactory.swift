//
//  FeedFeatureFactory.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public struct FeedFeatureFactory: @MainActor FeatureFactory {
    public let dependencies: FeedDependencies
    
    public init(dependencies: FeedDependencies) {
        self.dependencies = dependencies
    }

    @MainActor
    public func makeFeature() -> MicroFeature {
        FeedFeatureEntry(dependencies: dependencies)
    }
}
