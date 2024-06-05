import 'package:dokan/components/constants/app_colors.dart';
import 'package:flutter/material.dart';
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
        return Column(
          children: [
            Gap(20),
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
            Gap(20),
            Text(
              'Filter',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            filterItemCheckBox('Newest'),
            filterItemCheckBox('Oldest'),
            filterItemCheckBox('Price low > High'),
            filterItemCheckBox('Price high > Low'),
            filterItemCheckBox('Best Selling'),
          ],
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
                widget.onChange(text);
                setState(() {
                  selectedFilter = text;
                });
              }
            }),
        Text(
          text,
          style: TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
