//
//  FeedFeatureFactory.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

struct FeedFeatureFactory: FeatureFactory {
    let dependencies: FeedDependencies

    func makeFeature() -> MicroFeature {
        FeedFeatureEntry(dependencies: dependencies)
    }
}
