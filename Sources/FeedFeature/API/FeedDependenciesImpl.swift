//
//  FeedDependenciesImpl.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

/// Concrete implementation of `FeedDependencies`.
///
/// The shell app creates this and passes it into `FeedFeatureFactory` so the
/// Feed feature can access its API client and analytics without depending
/// directly on app‑level types.
public class FeedDependenciesImpl: FeedDependencies {
    public let feedAPI: any FeedFeatureAPI
    public let analytics: any Analytics
    
    public init(feedAPI: FeedFeatureAPI, analytics: Analytics) {
        self.feedAPI = feedAPI
        self.analytics = analytics
    }
}
