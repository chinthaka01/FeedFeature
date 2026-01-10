# FeedFeature

FeedFeature is a modular micro‑frontend that displays a feed of posts inside the Wefriends MFE demo iOS app. It is built with SwiftUI and integrates with the shared platform networking, analytics, and design system layers.

## Architecture

FeedFeature follows a lightweight MVVM structure:

- `FeedFeatureFactory` creates the feature entry and wires dependencies into the module.
- `FeedFeatureEntry` conforms to `MicroFeature` and exposes:
  - `id` and `title` for tab metadata.
  - `tabIcon` / `selectedTabIcon` for the tab bar.
  - `makeRootView()` to build the feature’s root SwiftUI view.
- `FeedRootView` hosts a `NavigationStack` and owns a `@StateObject` `FeedViewModel`.
- `FeedScreen` renders loading, error, empty, and content states using `FeedViewModel`.
- `PostCard` displays an individual post using shared `DesignSystem` components.
- `FeedViewModel` coordinates loading, updating, and deleting posts via `FeedFeatureAPI` and emits state via `@Published` properties.
- `FeedFeatureAPIClient` is the concrete implementation of `FeedFeatureAPI`, backed by the shared `Networking` abstraction.

## Dependencies

FeedFeature depends on shared platform modules:

- `PlatformKit`
  - `Networking` protocol for making BFF calls.
  - `Analytics` protocol for tracking user behavior.
  - `AppBroadcast` for cross‑feature notifications (e.g., self posts count).
- `DesignSystem`
  - `DSSpacing`, `DSTextStyle`, and `DSColor` for consistent styling.
  - `DSAvatar` and `DSButton` for reusable UI components.
- `SwiftUI` / `UIKit`
  - `SwiftUI` for views and navigation.
  - `UIKit` for tab icons (`UIImage`) on the feature entry.

The feature also assumes a `Post` model that is `Identifiable` and `Decodable` so it can be fetched over the network and rendered in lists.

## Networking

All server communication is done via `FeedFeatureAPI`:

- `fetchFeeds() async throws -> [Post]`
  - Implemented using `networking.fetchList(bffPath:type:)` with the base path `posts`.
- `updatePost(_:) async throws -> Post`
  - Implemented using `networking.updateRecord(bffPath:type:record:)` with `/posts/{id}`.
- `deletePost(_:) async throws`
  - Implemented using `networking.deleteRecord(bffPath:type:withID:)` on the `posts` path.

The concrete `FeedFeatureAPIClient` is initialized with an object conforming to `Networking`, which is provided by the host app.

## View Model Behavior

`FeedViewModel` is annotated with `@MainActor` and exposes:

- `@Published var posts: [Post]`
- `@Published var isLoading: Bool`
- `@Published var error: Error?`

Main operations:

- `loadFeed()`
  - Clears existing state, sets `isLoading = true`, and invokes `api.fetchFeeds()`.
  - Shuffles the resulting posts before publishing them.
  - On success, calls `broadcastSelfPostsCount()` to notify the rest of the app of the number of posts for the current user.
  - On failure, stores the error and logs a message.
- `updatePost(_:)`
  - Calls `api.updatePost` and logs failures.
- `deletePost(_:)`
  - Calls `api.deletePost` and logs failures.
- `broadcastSelfPostsCount()`
  - Filters posts for `userId == 1` and posts a notification using `NotificationCenter` with the `AppBroadcast.selfPostsCount` name and a `payload_count` in `userInfo`.

## UI States

`FeedScreen` renders four primary UI states:

- Loading
  - `ProgressView("Loading feed…")` while `isLoading` is true.
- Error
  - `ContentUnavailableView` with a retry action that triggers `loadFeed()` again.
- Empty
  - `ContentUnavailableView` describing an empty feed with a retry button.
- Content
  - `ScrollView` + `LazyVStack` of `PostCard` views.

Each `PostCard` shows:

- An avatar derived from `post.userId`.
- A header with “User {userId}” and the post title.
- The post body text, using `DesignSystem` typography and colors.
- A card background with spacing and corner radius defined by the design system.

## Integration

To integrate FeedFeature into the host app:

1. Construct `FeedDependencies` in the shell, providing:
   - A `FeedFeatureAPI` (e.g., `FeedFeatureAPIClient(networking: ...)`).
   - An `Analytics` implementation.
2. Create a `FeedFeatureFactory` with those dependencies.
3. Use `makeFeature()` from the factory to obtain a `MicroFeature`:
   - Use `id`, `title`, and icons to configure the tab bar item.
   - Call `makeRootView()` to embed the SwiftUI content in the tab’s navigation stack.

***

## How to wire it from the shell app

Example (pseudo‑code):

```swift
// 1. Create shared dependencies
let analytics: Analytics = AnalyticsImpl()
let networking: Networking = NetworkingImpl()

// 2. Create the feature API & dependencies
let feedAPI: FeedFeatureAPI = FeedFeatureAPIClient(networking: networking)
let feedDeps = FeedDependenciesImpl(feedAPI: feedAPI, analytics: analytics)

// 3. Create the feature factory
let feedFactory = FeedFeatureFactory(dependencies: profileDeps)

// 4. Build the MicroFeature and use it in the TabView
let feedFeature = feedFactory.makeFeature()

TabView {
    feedFeature
        .makeRootView()
        .tabItem {
            Image(uiImage: feedFeature.tabIcon)
            Text(feedFeature.title)
        }
}
```

This keeps the feature self‑contained and allows it to be developed, tested, and evolved independently while still using shared platform and design system building blocks.

***

## Other Related Repositories

### Shell App:
Shell - https://github.com/chinthaka01/Wefriendz

### Shared contracts:
PlatformKit - https://github.com/chinthaka01/PlatformKit
DesignSystem - https://github.com/chinthaka01/DesignSystem

### Micro Frontends:
Feed Feature - https://github.com/chinthaka01/FeedFeature
Friends Feature - https://github.com/chinthaka01/FriendsFeature
Profile Feature - https://github.com/chinthaka01/ProfileFeature

### Isolate Feature Testing Apps:
Friends Feature Testing App - https://github.com/chinthaka01/FriendsFeatureApp
Profile Feature Testing App - https://github.com/chinthaka01/ProfileFeatureApp
