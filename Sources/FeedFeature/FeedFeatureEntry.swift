import SwiftUI
import UIKit
import PlatformKit
import DesignSystem

struct FeedFeatureEntry: @MainActor MicroFeature {

    let id = "feeds"
    let title = "Feeds"
    let tabIcon: UIImage
    let selectedTabIcon: UIImage

    private let dependencies: FeedDependencies
    private let viewModel: FeedViewModel

    @MainActor
    init(dependencies: FeedDependencies) {
        self.dependencies = dependencies
        self.tabIcon = UIImage(systemName: "house")!
        self.selectedTabIcon = UIImage(systemName: "house")!
        
        self.viewModel = FeedViewModel(
            api: dependencies.feedAPI,
            analytics: dependencies.analytics
        )
    }

    @MainActor
    func makeRootView() -> AnyView {
        return AnyView(FeedRootView(viewModel: viewModel))
    }
}
