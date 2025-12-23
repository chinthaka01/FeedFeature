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
