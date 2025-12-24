//
//  FeedDependenciesImpl.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public class FeedDependenciesImpl: FeedDependencies {
    public let feedAPI: any FeedFeatureAPI
    public let analytics: any Analytics
    
    public init(feedAPI: FeedFeatureAPI, analytics: Analytics) {
        self.feedAPI = feedAPI
        self.analytics = analytics
    }
}
