import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final AppIcons appIcon;
  final bool? isOriginalColor;
  final double? size;
  final Color? color;
  const AppIcon(this.appIcon,
      {super.key, this.color, this.isOriginalColor = false, this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      IconPaths.getPath(appIcon),
      height: size ?? 12,
      width: size ?? 12,
      color: isOriginalColor! ? null : color ?? AppColors.grey,
      fit: size != null ? BoxFit.contain : BoxFit.none,
    );
  }
}
