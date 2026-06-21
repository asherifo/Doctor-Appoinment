import 'package:flutter/material.dart';

class BuildTag extends StatelessWidget {
  const BuildTag({super.key, required this.text, required this.bgColor, required this.textColor,});
  final String text;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }
}
