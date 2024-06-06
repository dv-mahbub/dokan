import 'dart:developer';

import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/global_widget/custom_bottom_sheet.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dokan/views/dashboard/product_list.dart';
import 'package:dokan/views/dashboard/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int bodyIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeBody(bodyIndex),
      floatingActionButton: fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar(),
    );
  }

  BottomAppBar bottomAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
      height: 65,
      color: AppColors.whiteBg,
      elevation: 25,
      shadowColor: Colors.black,
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: AppIcon(
              AppIcons.home,
              size: 24,
              color: bodyIndex == 0 ? AppColors.primary : null,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 0;
                });
              }
            },
          ),
          IconButton(
            icon: AppIcon(
              AppIcons.dashboard,
              color: bodyIndex == 1 ? AppColors.primary : null,
              size: 24,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 1;
                });
              }
            },
          ),
          SizedBox(width: 48), // Spacer for the FAB
          IconButton(
            icon: AppIcon(
              AppIcons.cart,
              color: bodyIndex == 3 ? AppColors.primary : null,
              size: 24,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 3;
                });
              }
            },
          ),
          IconButton(
            icon: AppIcon(
              AppIcons.person,
              color: bodyIndex == 4 ? AppColors.primary : null,
              size: 24,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 4;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget fab() {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF679B),
            Color(0xFFFF7B51),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFB82D48).withOpacity(0.15),
            offset: Offset(0, 12),
            blurRadius: 28,
          ),
        ],
      ),
      child: RawMaterialButton(
        shape: CircleBorder(),
        onPressed: () {
          if (mounted) {
            setState(
              () {
                bodyIndex = 2;
              },
            );
          }
        },
        child: AppIcon(
          AppIcons.search,
          color: AppColors.whiteText,
          size: 24,
        ),
      ),
    );
  }

  Widget homeBody(int index) {
    log('$index');
    switch (index) {
      case 0:
        return const ProductList();
      case 1:
        return Center(
          child: Text('Dashboard'),
        );
      case 2:
        return Center(
          child: Text('Search'),
        );
      case 3:
        return Center(
          child: Text('Cart'),
        );
      default:
        return const Profile();
    }
  }
}
