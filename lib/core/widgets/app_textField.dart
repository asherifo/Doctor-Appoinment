import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final Function onChang;
  final Function validator;
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;


  const AppTextField({super.key, required this.onChang, required this.validator, required this.controller, required this.hint, required this.obscure,required this.keyboardType, required this.prefixIcon, required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: validator(),
      controller: controller,
      onChanged: onChang(),
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon == null ?null :Icon(prefixIcon),
        hintText: hint,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),

          borderSide: BorderSide(color: Colors.grey,width: 1.4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary,width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color:AppColors.primary,width: 1),),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color:Colors.red,width: 1.4),),
      ),


    );
  }
}
