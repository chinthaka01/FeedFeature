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

    init(dependencies: FeedDependencies) {
        self.dependencies = dependencies
        self.tabIcon = UIImage(systemName: "house")!
        self.selectedTabIcon = UIImage(systemName: "house")!
    }

    @MainActor
    func makeRootView() -> AnyView {
        let viewModel = FeedViewModel(
            api: dependencies.feedAPI,
            analytics: dependencies.analytics
        )
        return AnyView(FeedRootView(viewModel: viewModel))
    }
}
