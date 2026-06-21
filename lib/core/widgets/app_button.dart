import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:doctor_appoinment/core/utils/txt_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  double width;
  String txt;
  final VoidCallback onPress;
   AppButton({super.key,required this.width ,required this.txt, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 48,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primary ),
        child: Center(
          child: Text(txt,
              style: TxtStyles.txtButtons),
        ),
      ),
    );
  }
}
