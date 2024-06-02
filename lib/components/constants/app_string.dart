import 'package:dokan/components/constants/app_icons.dart';

class AppImages {
  static String logo = 'assets/images/logo.png';
}

class IconPaths {
  static const String _basePath = 'assets/icons';

  static String getPath(AppIcons icon) {
    switch (icon) {
      case AppIcons.cart:
        return '$_basePath/cart.png';
      case AppIcons.dashboard:
        return '$_basePath/dashboard.png';
      case AppIcons.email:
        return '$_basePath/email.png';
      case AppIcons.facebook:
        return '$_basePath/facebook.png';
      case AppIcons.filter:
        return '$_basePath/filter.png';
      case AppIcons.google:
        return '$_basePath/google.png';
      case AppIcons.hamburger:
        return '$_basePath/hamburger.png';
      case AppIcons.heart:
        return '$_basePath/heart.png';
      case AppIcons.home:
        return '$_basePath/home.png';
      case AppIcons.notification:
        return '$_basePath/notification.png';
      case AppIcons.password:
        return '$_basePath/password.png';
      case AppIcons.person:
        return '$_basePath/person.png';
      case AppIcons.search:
        return '$_basePath/search.png';
      default:
        return '';
    }
  }
}
