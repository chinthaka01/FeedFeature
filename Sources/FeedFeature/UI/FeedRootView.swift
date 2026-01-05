//
//  File.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import SwiftUI
import PlatformKit
import DesignSystem

/// Root SwiftUI entry for the Feed feature.
///
/// Hosts the navigation stack and wires the shared `FeedViewModel` into the
/// first screen of the feature.
struct FeedRootView: View {
    @StateObject private var viewModel: FeedViewModel

    init(viewModel: FeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            FeedScreen(viewModel: viewModel)
        }
    }
}
