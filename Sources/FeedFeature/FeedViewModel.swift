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
    
    @Published var feedDTO: FeedDTOImpl?

    init(api: FeedFeatureAPI, analytics: Analytics) {
        self.api = api
        self.analytics = analytics
    }
    
    func loadFeed() {

    }
}
