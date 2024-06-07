import 'dart:convert';
import 'dart:developer';

import 'package:dokan/components/constants/api_endpoints.dart';
import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:dokan/components/controllers/api_controllers/post_api_controller.dart';
import 'package:dokan/components/controllers/provider/user_info_provider.dart';
import 'package:dokan/components/controllers/shared_preference/token_store.dart';
import 'package:dokan/components/global_functions/navigate.dart';
import 'package:dokan/components/global_widget/custom_button.dart';
import 'package:dokan/components/global_widget/custom_field.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dokan/components/global_widget/loading.dart';
import 'package:dokan/components/global_widget/show_message.dart';
import 'package:dokan/models/user_info_model.dart';
import 'package:dokan/views/auth/registration_page.dart';
import 'package:dokan/views/dashboard/homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../components/controllers/api_controllers/api_response_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(55),
              SvgPicture.asset(
                AppImages.logo,
                width: 150,
                fit: BoxFit.fitWidth,
              ),
              const Gap(45),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Gap(25),
              CustomField(
                  hintText: 'Email',
                  prefixIcon: const AppIcon(AppIcons.email),
                  controller: emailController),
              const Gap(20),
              CustomField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
                prefixIcon: const AppIcon(AppIcons.password),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.grey, fontSize: 13),
                    ),
                  ),
                  Gap(.07.sw),
                ],
              ),
              const Gap(25),
              CustomButton(
                text: 'Login',
                onTap: onTapLogin,
              ),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialLoginContainer(appIcon: AppIcons.facebook),
                  const Gap(8),
                  socialLoginContainer(appIcon: AppIcons.google),
                ],
              ),
              const Gap(30),
              TextButton(
                onPressed: () {
                  if (mounted) {
                    navigate(context: context, child: const RegistrationPage());
                  }
                },
                child: Text(
                  'Create New Account',
                  style: TextStyle(color: AppColors.grey, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapLogin() async {
    if (emailController.text.isEmpty) {
      showError('Enter email');
    } else if (!EmailValidator.validate(emailController.text)) {
      showError('Enter valid email');
    } else if (passwordController.text.isEmpty) {
      showError('Enter password');
    } else {
      try {
        Map body = {
          'username': emailController.text,
          'password': passwordController.text
        };
        loadingDialog(context);
        ApiResponseData result =
            await postApiController(ApiEndpoints.login, false, body);
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
            TokenStore.setBearerToken(userProvider.userData!.token!);
            log(result.responseBody);
            replaceNavigate(context: context, child: const Homepage());
          }
        } else {
          showError(json.decode(result.responseBody)["message"]);
          log('Login failed: ${result.statusCode} - ${result.responseBody}');
        }
      } catch (e) {
        log('Login failed: $e');
        showError('Failed to Login');
      }
    }
  }

  Container socialLoginContainer({required AppIcons appIcon}) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: AppColors.whiteBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: AppIcon(
        appIcon,
      ),
    );
  }

  showError(String message) {
    if (mounted) {
      showErrorMessage(context, message);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
