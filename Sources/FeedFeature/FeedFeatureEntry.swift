import SwiftUI
import UIKit
import PlatformKit
import DesignSystem

public struct FeedFeatureEntry: MicroFeature {
    public let id = "feeds"
    public let title = "Feeds"
    public let tabIcon: UIImage

    private let dependencies: FeedDependencies

    public init(
        dependencies: FeedDependencies,
        tabIcon: UIImage = UIImage(systemName: "banknote")!
    ) {
        self.dependencies = dependencies
        self.tabIcon = tabIcon
    }

    public func makeRootView() -> AnyView {
        let viewModel = FeedViewModel(
            api: dependencies.feedAPI,
            analytics: dependencies.analytics
        )
        return AnyView(FeedRootView(viewModel: viewModel))
    }
}
