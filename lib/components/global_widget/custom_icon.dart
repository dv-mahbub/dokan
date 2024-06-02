import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final AppIcons appIcon;
  final bool? isOriginalColor;
  final double? height;
  final double? width;
  final Color? color;
  const AppIcon(this.appIcon,
      {super.key,
      this.height,
      this.width,
      this.color,
      this.isOriginalColor = false});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      IconPaths.getPath(appIcon),
      height: height ?? 15,
      width: width ?? 15,
      color: isOriginalColor! ? null : color ?? AppColors.grey,
    );
  }
}
