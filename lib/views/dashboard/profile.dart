import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:dokan/components/global_widget/custom_button.dart';
import 'package:dokan/components/global_widget/custom_field.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
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
              const Gap(20),
              const Text(
                'My Account',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const Gap(35),
              profilePicture(),
              const Gap(40),
              Text(
                'Name of the person',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                'email@mail.com',
                style: GoogleFonts.lato(
                  textStyle:
                      const TextStyle(fontSize: 15, color: Color(0xff535353)),
                ),
              ),
              const Gap(40),
              optionsList(),
              const Gap(30),
              CustomButton(
                text: 'Log Out',
                onTap: () {},
                width: .88.sw,
              ),
              const Gap(35),
            ],
          ),
        ),
      ),
    );
  }

  Container optionsList() {
    return Container(
      width: .88.sw,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: AppColors.whiteBg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff4d5877).withOpacity(.13),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Gap(15),
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
                  const Gap(30),
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
                        backgroundColor: const Color(0xff1ABC9C),
                      ),
                    ],
                  ),
                  const Gap(30),
                ],
              )),
          const Divider(),
          optionContainer(
              text: 'Password', appIcons: AppIcons.password, onTap: () {}),
          const Divider(),
          optionContainer(
              text: 'Notification',
              appIcons: AppIcons.notification,
              onTap: () {}),
          const Divider(),
          optionContainer(
              text: 'Wishlist',
              appIcons: AppIcons.heart,
              onTap: () {},
              additionalText: '(00)'),
          const Gap(7),
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
        const Gap(13),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff263238),
          ),
        ),
        const Gap(7),
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
            const Gap(15),
            Text(
              text,
              style: const TextStyle(fontSize: 17),
            ),
            Visibility(
              visible: additionalText != null,
              child: Text(
                ' $additionalText',
                style: TextStyle(fontSize: 17, color: AppColors.greyText),
              ),
            ),
            const Spacer(),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              // size: 12,
              color: const Color(0xff899AA2),
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
      dashPattern: const [4, 4],
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
