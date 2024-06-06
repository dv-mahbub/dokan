import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:dokan/components/global_widget/custom_button.dart';
import 'package:dokan/components/global_widget/custom_field.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isExpanded = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController appartmentController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    streetController.dispose();
    appartmentController.dispose();

    zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(20),
              Text(
                'My Account',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Gap(35),
              profilePicture(),
              Gap(40),
              Text(
                'Name of the person',
                style: GoogleFonts.lato(
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                'email@mail.com',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 15, color: Color(0xff535353)),
                ),
              ),
              Gap(40),
              optionsList(),
            ],
          ),
        ),
      ),
    );
  }

  Container optionsList() {
    return Container(
      width: .88.sw,
      padding: EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: AppColors.whiteBg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xff4D587721),
            blurRadius: 6,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Gap(15),
          optionContainer(
              text: 'Account',
              appIcons: AppIcons.person,
              onTap: () {
                if (mounted) {
                  setState(
                    () {
                      isExpanded = !isExpanded;
                    },
                  );
                }
              }),
          Visibility(
              visible: isExpanded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inputContainer(
                      text: 'Email',
                      hint: 'yourEmail@xmail.com',
                      controller: emailController),
                  inputContainer(
                      text: 'Full Name',
                      hint: 'William Bennett',
                      controller: nameController),
                  inputContainer(
                      text: 'Street Address',
                      hint: '465 Nolan Causeway Suite 079',
                      controller: streetController),
                  inputContainer(
                      text: 'Apt, Suite, Bldg (optional)',
                      hint: 'Unit 512',
                      controller: appartmentController),
                  inputContainer(
                      text: 'Zip Code',
                      hint: '77017',
                      inputFieldWidth: 100,
                      controller: zipCodeController),
                  Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: 'Cancel',
                        onTap: () {},
                        width: .34.sw,
                        textColor: const Color(0xff607374),
                        backgroundColor: Colors.transparent,
                        isBorderNeeded: true,
                      ),
                      CustomButton(
                        text: 'Save',
                        onTap: () {},
                        width: .34.sw,
                        backgroundColor: Color(0xff1ABC9C),
                      ),
                    ],
                  ),
                  Gap(30),
                ],
              )),
          Divider(),
          optionContainer(
              text: 'Password', appIcons: AppIcons.password, onTap: () {}),
          Divider(),
          optionContainer(
              text: 'Notification',
              appIcons: AppIcons.notification,
              onTap: () {}),
          Divider(),
          optionContainer(
              text: 'Wishlist',
              appIcons: AppIcons.heart,
              onTap: () {},
              additionalText: '(00)'),
          Gap(7),
        ],
      ),
    );
  }

  Widget inputContainer(
      {required String text,
      required String hint,
      required TextEditingController controller,
      double? inputFieldWidth}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(13),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff263238),
          ),
        ),
        Gap(7),
        CustomField(
          hintText: hint,
          width: inputFieldWidth,
          controller: controller,
          isMinimalDesign: true,
        ),
      ],
    );
  }

  Widget optionContainer(
      {required String text,
      required AppIcons appIcons,
      required Function() onTap,
      String? additionalText}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            AppIcon(
              appIcons,
              size: 17,
            ),
            Gap(15),
            Text(
              text,
              style: TextStyle(fontSize: 17),
            ),
            Visibility(
              visible: additionalText != null,
              child: Text(
                ' $additionalText',
                style: TextStyle(fontSize: 17, color: AppColors.greyText),
              ),
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              // size: 12,
              color: Color(0xff899AA2),
            ),
          ],
        ),
      ),
    );
  }

  DottedBorder profilePicture() {
    return DottedBorder(
      color: AppColors.primary,
      borderType: BorderType.Circle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: SizedBox(
            height: 112,
            width: 112,
            child: Image.asset(
              DemoImage.person,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
