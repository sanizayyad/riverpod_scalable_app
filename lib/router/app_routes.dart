

enum AppRoute {
  login('/login'),
  notes('/notes');

  /// Absolute path relative to the root page.
  /// Eg ```context.go(route)```
  ///
  /// `name` is used to add sub routes to the tree
  const AppRoute(this.route);
  final String route;
}