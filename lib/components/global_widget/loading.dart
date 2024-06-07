import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

loadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Lottie.asset('assets/json/dot_circle_loading.json'),
        );
      });
}

popAfterShortTime(BuildContext context) {
  Future.delayed(const Duration(milliseconds: 150), () {
    Navigator.of(context).pop(); // Close the dialog
  });
}
