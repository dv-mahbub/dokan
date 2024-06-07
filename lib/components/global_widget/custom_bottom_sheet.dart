import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/global_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomBottomSheet extends StatefulWidget {
  final String selectedFilter;
  final Function(String newValue) onChange;
  const CustomBottomSheet(
      {super.key, required this.selectedFilter, required this.onChange});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String selectedFilter = '';

  @override
  void initState() {
    selectedFilter = widget.selectedFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: 70,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const Gap(20),
              const Text(
                'Filter',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              filterItemCheckBox('Newest'),
              filterItemCheckBox('Oldest'),
              filterItemCheckBox('Price low > High'),
              filterItemCheckBox('Price high > Low'),
              filterItemCheckBox('Best Selling'),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          text: 'Cancel',
                          onTap: () {
                            widget.onChange('');
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                          backgroundColor: AppColors.whiteBg,
                          textColor: AppColors.greyText,
                          isBorderNeeded: true,
                          width: .4.sw,
                        ),
                        CustomButton(
                          text: 'Apply',
                          backgroundColor: AppColors.greenBg,
                          onTap: () {
                            if (mounted) {
                              widget.onChange(selectedFilter);
                              Navigator.pop(context);
                            }
                          },
                          width: .4.sw,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Row filterItemCheckBox(String text) {
    return Row(
      children: [
        Checkbox(
            value: text == selectedFilter,
            onChanged: (value) {
              if (value != null && value) {
                setState(() {
                  selectedFilter = text;
                });
              }
            }),
        Text(
          text,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
