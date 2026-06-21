import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context,'Login' );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/doctor.png",height: 200,),
            SizedBox(height: 20,),
            Text(
              'DocPoint',
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold,fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
