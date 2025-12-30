//
//  File.swift
//  FeedFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import SwiftUI

struct FeedScreen: View {
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
//        List(viewModel.feeds) { feed in
//            VStack(alignment: .leading) {
//                Text(feed.name)
//                    .font(.headline)
//                Text(feed.formattedBalance)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
//        }
        Text("")
        .navigationTitle("Feeds")
        .onAppear {
            Task {
                await viewModel.loadFeed()
            }
        }
    }
}
