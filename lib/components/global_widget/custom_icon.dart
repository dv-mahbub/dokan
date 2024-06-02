import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final AppIcons appIcon;
  final double? height;
  final double? width;
  final Color? color;
  const CustomIcon(
      {super.key, required this.appIcon, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      IconPaths.getPath(appIcon),
      height: height ?? 27,
      width: width ?? 27,
      color: color ?? AppColors.grey,
      fit: BoxFit.contain,
    );
  }
}
