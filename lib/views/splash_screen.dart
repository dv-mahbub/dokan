import 'dart:convert';
import 'dart:developer';

import 'package:dokan/components/constants/api_endpoints.dart';
import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:dokan/components/controllers/api_controllers/api_response_data.dart';
import 'package:dokan/components/controllers/api_controllers/get_api_controller.dart';
import 'package:dokan/components/controllers/provider/user_info_provider.dart';
import 'package:dokan/components/controllers/shared_preference/token_store.dart';
import 'package:dokan/components/global_functions/navigate.dart';
import 'package:dokan/components/global_widget/show_message.dart';
import 'package:dokan/models/user_info_model.dart';
import 'package:dokan/views/auth/login_page.dart';
import 'package:dokan/views/dashboard/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
    sessionCheck();
    // Future.delayed(const Duration(seconds: 2), () {
    //   replaceNavigate(context: context, child: const LoginPage());
    // });
  }

  void sessionCheck() async {
    String? token = await TokenStore.getBearerToken();
    if (token == null || token.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        replaceNavigate(context: context, child: const LoginPage());
      });
    } else {
      try {
        ApiResponseData result =
            await getApiController(ApiEndpoints.getUserData, true);
        if (mounted) {
          Navigator.pop(context);
        }
        if (result.statusCode == 200) {
          if (mounted) {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.updateUserData(
              UserInfoModel.fromJson(
                jsonDecode(result.responseBody),
              ),
            );
            if (mounted) {
              replaceNavigate(context: context, child: const Homepage());
            }
          }
        } else {
          showError(json.decode(result.responseBody)["message"]);
          log('Get user (login) failed: ${result.statusCode} - ${result.responseBody}');
          if (mounted) {
            replaceNavigate(context: context, child: const LoginPage());
          }
        }
      } catch (e) {
        log('Get user details failed: $e');
        showError('Failed to fetch user details');
        if (mounted) {
          replaceNavigate(context: context, child: const LoginPage());
        }
      }
    }
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

  void showError(String message) {
    if (mounted) {
      showErrorMessage(context, message);
    }
  }
}
