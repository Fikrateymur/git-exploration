enum EnumRoutes {
  splash(path: '/splash'),
  onboarding(path: '/onboarding'),
  login(path: '/login');

  const EnumRoutes({required this.path});

  final String path;
}
