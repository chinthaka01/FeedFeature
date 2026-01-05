//
//  FeedFeatureFactory.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

/// Factory that creates the Feed micro feature.
///
/// The shell app owns an instance of this type and calls `makeFeature()`
/// to obtain the tab descriptor and root view for the Feed module.
@MainActor
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
