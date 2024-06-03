import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final AppIcons appIcon;
  final double? size;
  final Color? color;
  const AppIcon(this.appIcon, {super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 12,
      width: size ?? 12,
      child: SvgPicture.asset(
        IconPaths.getPath(appIcon),
        colorFilter:
            ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcATop),
        fit: size != null ? BoxFit.contain : BoxFit.none,
      ),
    );
  }
}
