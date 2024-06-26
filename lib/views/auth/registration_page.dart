import 'dart:convert';
import 'dart:developer';

import 'package:dokan/components/constants/api_endpoints.dart';
import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/controllers/api_controllers/api_response_data.dart';
import 'package:dokan/components/controllers/api_controllers/get_api_controller.dart';
import 'package:dokan/components/controllers/api_controllers/post_api_controller.dart';
import 'package:dokan/components/controllers/provider/user_info_provider.dart';
import 'package:dokan/components/controllers/shared_preference/token_store.dart';
import 'package:dokan/components/global_functions/navigate.dart';
import 'package:dokan/components/global_widget/custom_button.dart';
import 'package:dokan/components/global_widget/custom_field.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dokan/components/global_widget/loading.dart';
import 'package:dokan/components/global_widget/show_message.dart';
import 'package:dokan/models/login_response_model.dart';
import 'package:dokan/models/user_info_model.dart';
import 'package:dokan/views/auth/login_page.dart';
import 'package:dokan/views/dashboard/homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(10),
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
                obscureText: true,
                prefixIcon: const AppIcon(AppIcons.password),
              ),
              const Gap(20),
              CustomField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmPasswordController,
                prefixIcon: const AppIcon(AppIcons.password),
              ),
              const Gap(45),
              CustomButton(text: 'Sign Up', onTap: onTapSignUp),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialLoginContainer(appIcon: AppIcons.facebook),
                  const Gap(8),
                  socialLoginContainer(appIcon: AppIcons.search),
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
    );
  }

  void onTapSignUp() async {
    if (nameController.text.isEmpty) {
      showError('Enter your name');
    } else if (emailController.text.isEmpty) {
      showError('Enter email');
    } else if (!EmailValidator.validate(emailController.text)) {
      showError('Enter valid email');
    } else if (passwordController.text.isEmpty) {
      showError('Enter password');
    } else if (confirmPasswordController.text.isEmpty) {
      showError('Enter confirm password');
    } else if (passwordController.text != confirmPasswordController.text) {
      showError('Password not matched');
    } else {
      try {
        Map body = {
          'username': nameController.text,
          'email': emailController.text,
          'password': passwordController.text
        };
        loadingDialog(context);
        ApiResponseData result =
            await postApiController(ApiEndpoints.registration, false, body);
        if (mounted) {
          Navigator.pop(context);
        }
        if (result.statusCode == 200) {
          if (mounted) {
            showSuccessMessage(context, 'Successfully registered');
            loginToGetToken();
          }
        } else {
          showError(json.decode(result.responseBody)["message"]);
          log('Registration failed: ${result.statusCode} - ${result.responseBody}');
        }
      } catch (e) {
        log('Registration failed: $e');
        showError('Failed to register');
      }
    }
  }

  void loginToGetToken() async {
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
          final userData =
              LoginResponseModel.fromJson(jsonDecode(result.responseBody));
          TokenStore.setBearerToken(userData.token!);
          getUserDetails();
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

  void getUserDetails() async {
    try {
      loadingDialog(context);
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
          replaceNavigate(context: context, child: const Homepage());
        }
      } else {
        showError(json.decode(result.responseBody)["message"]);
        log('Failed to fetch user details: ${result.statusCode} - ${result.responseBody}');
      }
    } catch (e) {
      log('Failed - Get details: $e');
      showError('Failed to fetch user data');
    }
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

  showError(String message) {
    if (mounted) {
      showErrorMessage(context, message);
    }
  }
}
