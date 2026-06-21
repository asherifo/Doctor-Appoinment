import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class BuildTimePeriodHeader extends StatelessWidget {
   BuildTimePeriodHeader({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,


          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary),
        ),
      ],
    );
  }
}
