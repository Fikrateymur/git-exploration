enum EnumRoutes {
  splash(path: '/splash'),
  onboarding(path: '/onboarding'),
  login(path: '/login'),
  home(path: '/home');

  const EnumRoutes({required this.path});

  final String path;
}
