import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:dokan/components/global_functions/navigate.dart';
import 'package:dokan/components/global_widget/custom_button.dart';
import 'package:dokan/components/global_widget/custom_field.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dokan/main.dart';
import 'package:dokan/views/auth/registration_page.dart';
import 'package:dokan/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

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
              Gap(55),
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
                  onTap: () {
                    if (mounted) {
                      navigate(context: context, child: const Homepage());
                    }
                  }),
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
