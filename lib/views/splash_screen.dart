import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:dokan/components/global_functions/navigate.dart';
import 'package:dokan/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isExpanded = true;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      replaceNavigate(context: context, child: const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: isExpanded ? 150 : 70,
              width: isExpanded ? 150 : 70,
              curve: Curves.bounceOut,
              child: SvgPicture.asset(
                AppImages.logo,
                fit: BoxFit.contain,
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
