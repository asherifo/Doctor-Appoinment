import 'package:flutter/material.dart';

class ContinueWithButton extends StatelessWidget {
  String image;
  String txt;
  final VoidCallback onPress;
   ContinueWithButton({super.key,required this.image,required this.txt, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 48,
        width: 120,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1,color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Image.asset(image),
          Text(txt,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
        ],),
      ),
    );
  }
}
