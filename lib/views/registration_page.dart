import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/global_functions/navigate.dart';
import 'package:dokan/components/global_widget/custom_button.dart';
import 'package:dokan/components/global_widget/custom_field.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dokan/main.dart';
import 'package:dokan/views/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profilePicture(),
                const Gap(35),
                CustomField(
                    hintText: 'Name',
                    prefixIcon: const AppIcon(AppIcons.email),
                    controller: nameController),
                const Gap(20),
                CustomField(
                    hintText: 'Email',
                    prefixIcon: const AppIcon(AppIcons.email),
                    controller: emailController),
                const Gap(20),
                CustomField(
                  hintText: 'Password',
                  controller: passwordController,
                  prefixIcon: const AppIcon(AppIcons.password),
                ),
                const Gap(20),
                CustomField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                  prefixIcon: const AppIcon(AppIcons.password),
                ),
                const Gap(45),
                CustomButton(text: 'Sign Up', onTap: () {}),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialLoginContainer(appIcon: AppIcons.facebook),
                    const Gap(8),
                    socialLoginContainer(appIcon: AppIcons.google),
                  ],
                ),
                const Gap(35),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: AppColors.blackText,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: AppColors.blueText,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (mounted) {
                              navigate(
                                  context: context, child: const LoginPage());
                            }
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profilePicture() {
    return InkWell(
      child: Stack(
        children: [
          Container(
            height: 121,
            width: 121,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteBg,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(.1),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const AppIcon(
              AppIcons.person,
              size: 5,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primary),
              child: AppIcon(
                AppIcons.camera,
                size: 10,
                color: AppColors.whiteText,
              ),
            ),
          )
        ],
      ),
    );
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
