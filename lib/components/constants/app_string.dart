import 'package:dokan/components/constants/app_icons.dart';

class AppImages {
  static String logo = 'assets/images/logo.svg';
}

class IconPaths {
  static const String _basePath = 'assets/icons';

  static String getPath(AppIcons icon) {
    switch (icon) {
      case AppIcons.cart:
        return '$_basePath/cart.svg';
      case AppIcons.dashboard:
        return '$_basePath/dashboard.svg';
      case AppIcons.email:
        return '$_basePath/email.svg';
      case AppIcons.facebook:
        return '$_basePath/facebook.svg';
      case AppIcons.filter:
        return '$_basePath/filter.svg';
      case AppIcons.google:
        return '$_basePath/google.svg';
      case AppIcons.hamburger:
        return '$_basePath/hamburger.svg';
      case AppIcons.heart:
        return '$_basePath/heart.svg';
      case AppIcons.home:
        return '$_basePath/home.svg';
      case AppIcons.notification:
        return '$_basePath/notification.svg';
      case AppIcons.password:
        return '$_basePath/password.svg';
      case AppIcons.person:
        return '$_basePath/person.svg';
      case AppIcons.search:
        return '$_basePath/search.svg';
      case AppIcons.camera:
        return '$_basePath/camera.svg';
      default:
        return '';
    }
  }
}
