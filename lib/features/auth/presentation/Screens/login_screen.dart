import 'package:doctor_appoinment/features/auth/data/login_model.dart';
import 'package:doctor_appoinment/features/auth/logic/auth_cubit.dart';
import 'package:doctor_appoinment/features/auth/logic/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_textField.dart';
import '../widgets/continue_with_button.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final TextEditingController _email = TextEditingController();
 final TextEditingController _password = TextEditingController();
 final formKey = GlobalKey<FormState>();
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromRGBO(214, 227, 255, 1),
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/icon_app.png'),
              Image.asset('assets/images/heading.png'),
            ],),
        ),),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Login Successfully'),
                Icon(Icons.check_circle,color: AppColors.BackgroundColor,)
              ],),
              backgroundColor: AppColors.primary,));
            Navigator.pushReplacementNamed(context, 'AllDoctors');
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMsg), backgroundColor: Colors.red,));
          }
        }, builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Card(
              color: Colors.white,
              margin: EdgeInsetsGeometry.only(
                  left: 30, top: 30, bottom: 22, right: 30),

              child: Form(
                key: formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20),),
                    Center(
                      child: Text('Welcome Back',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(17, 28, 44, 1),
                        ),
                      ),),
                    Center(
                      child: Text(
                        'Sign in to securely access your\nmedical records and upcoming\nappointments.',
                        textAlign: TextAlign.center,
                        style: TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(66, 71, 82, 1),
                        ),
                      ),),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 25, bottom: 10),
                      child: Text('Email Address', style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600,),),
                    ),
                    Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                          horizontal: 20),
                      child: AppTextField(onChang: () {},
                          validator: () {},
                          controller: _email,
                          hint: 'Patient@example.com',
                          obscure: false,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          suffixIcon: null),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 25, bottom: 10, right: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, children: [
                        Text('Password', style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600,),),
                        InkWell(
                            onTap: () {},
                            child: Text('Forget Password?', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary),)),
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                          horizontal: 20),
                      child: AppTextField(onChang: () {},
                          validator: () {},
                          controller: _password,
                          hint: '***********',
                          obscure: true,
                          keyboardType: TextInputType.name,
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: null),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: isChecked,
                              activeColor: const Color(0xFF004687),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: const BorderSide(color: Colors.grey),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Remember me for 30 days',
                            style: TextStyle(
                              color: Color.fromRGBO(66, 71, 82, 1),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Center(child: AppButton(width: 284,
                          txt: (state is AuthLoadingState)
                              ? 'Loading...!'
                              : 'Sign In',
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(LoginModel(
                                  email: _email.text,
                                  password: _password.text));

                            }
                          })),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 30, right: 30),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContinueWithButton(image: 'assets/images/Vector.png',
                            txt: 'Google',
                            onPress: () {},),
                          SizedBox(width: 10,),
                          ContinueWithButton(image: 'assets/images/apple.png',
                            txt: 'Apple',
                            onPress: () {},),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ", style: TextStyle(
                            color: Color.fromRGBO(66, 71, 82, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,),),
                          InkWell(onTap: () {
                            Navigator.pushNamed(context,'Register');
                          },
                              child: Text('Create one here', style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,),))
                        ],
                      ),
                    ), SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          ),
        );
      },

      ),


    );
  }
}
