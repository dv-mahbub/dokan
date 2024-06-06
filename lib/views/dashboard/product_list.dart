import 'dart:developer';

import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/constants/app_string.dart';
import 'package:dokan/components/global_widget/custom_bottom_sheet.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String selectedFilter = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gap(40),
                Text(
                  'Product List',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  padding: EdgeInsets.only(right: 25),
                  onPressed: () {},
                  icon: SizedBox(
                    height: 25,
                    width: 25,
                    child: AppIcon(AppIcons.search),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showBottomSheet();
            },
            child: Container(
              width: .87.sw,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.whiteBg,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(.1),
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Gap(15),
                  AppIcon(
                    AppIcons.filter,
                    size: 20,
                  ),
                  Gap(10),
                  Text(
                    'Filter',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyText),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Sort by',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyText),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.greyText,
                  ),
                  Gap(15),
                  AppIcon(
                    AppIcons.hamburger,
                    size: 20,
                    color: AppColors.greyText,
                  ),
                  Gap(15),
                ],
              ),
            ),
          ),
          const Gap(4),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(12),
                  SizedBox(
                    width: 1.sw,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        productContainer(),
                        productContainer(),
                        productContainer(),
                        productContainer(),
                        productContainer(),
                        productContainer(),
                        productContainer(),
                        productContainer(),
                        productContainer(),
                      ],
                    ),
                  ),
                  Gap(30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container productContainer() {
    return Container(
      width: ScreenUtil().screenWidth < 600 ? .43.sw : .28.sw,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.whiteBg,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: AppColors.shadowColor.withOpacity(.13),
            offset: const Offset(2, 3),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              DemoImage.person,
              width: ScreenUtil().screenWidth < 600 ? .43.sw : .28.sw,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Man Stylish Dresses…\n',
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Text(
                          '\$550',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyText,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Gap(3),
                        Text(
                          '\$789',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    itemSize: 17,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Gap(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      // isDismissible: false,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          selectedFilter: selectedFilter,
          onChange: (newValue) {
            if (mounted) {
              selectedFilter = newValue;
              log(selectedFilter);
            }
          },
        );
      },
    );
  }
}
