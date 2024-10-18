enum EnumRoutes {
  splash(path: '/splash'),
  onboarding(path: '/onboarding'),
  login(path: '/login'),
  home(path: '/home'),
  settings(path: '/settings');

  const EnumRoutes({required this.path});

  final String path;
}
