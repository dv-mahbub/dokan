import 'package:dokan/components/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function() onTap;
  final double? height;
  final Color? textColor;
  final Color? backgroundColor;
  final double? width;
  final bool? isBorderNeeded;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.icon,
      this.width,
      this.height,
      this.backgroundColor,
      this.isBorderNeeded,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 61,
        width: width ?? .82.sw,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(7),
          border: isBorderNeeded != null && isBorderNeeded!
              ? Border.all(
                  color: Color(0xff979797).withOpacity(.6),
                  width: 1,
                )
              : null,
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                  maxLines: 1,
                  softWrap: true,
                ),
        ),
      ),
    );
  }
}
