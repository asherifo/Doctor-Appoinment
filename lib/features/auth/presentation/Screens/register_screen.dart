
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_textField.dart';

import '../../data/register_model.dart';
import '../../logic/auth_cubit.dart';
import '../../logic/auth_state.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isChecked = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        RegisterRequestModel(
          name: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          gender: _genderController.text.trim(),
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
        ),
      );
    }
  }

  Widget _buildLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardType,
    bool obscure = false,
    IconData? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppTextField(
        controller: controller,
        hint: hint,
        keyboardType: keyboardType,
        obscure: obscure,
        prefixIcon: prefixIcon,
        suffixIcon: null,
        onChang: () {},
        validator: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E3FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/icon_app.png'),
              Image.asset('assets/images/heading.png'),
            ],
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(duration: Duration(seconds: 2),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Register Successfully'),
                    Icon(Icons.check_circle,color: AppColors.BackgroundColor,)
                  ],),
                backgroundColor: AppColors.primary,
              ),
            );
            Navigator.pushReplacementNamed(context, 'AllDoctors');
          }

          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111C2C),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Fill in your details to get started with\nDocPoint.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF424752),
                          ),
                        ),
                      ),

                      _buildLabel('Full Name'),
                      _buildTextField(
                        controller: _fullNameController,
                        hint: 'e.g Jane Doe',
                        keyboardType: TextInputType.name,
                      ),

                      _buildLabel('Email'),
                      _buildTextField(
                        controller: _emailController,
                        hint: 'jane@example.com',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      _buildLabel('Phone'),
                      _buildTextField(
                        controller: _phoneController,
                        hint: '(555) 000-0000',
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone,
                      ),

                      _buildLabel('Gender'),
                      _buildTextField(
                        controller: _genderController,
                        hint: 'Add your Gender',
                        keyboardType: TextInputType.text,
                      ),

                      _buildLabel('Password'),
                      _buildTextField(
                        controller: _passwordController,
                        hint: 'Create a Strong password',
                        keyboardType: TextInputType.visiblePassword,
                        obscure: true,
                      ),

                      _buildLabel('Confirm Password'),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        hint: 'Confirm password',
                        keyboardType: TextInputType.visiblePassword,
                        obscure: true,
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
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'I agree to the Terms of Service',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF424752),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          'and Privacy Policy',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: AppButton(
                            width: 284,
                            txt: state is RegisterLoadingState
                                ? 'Loading...'
                                : 'Sign Up',
                            onPress: _register,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Color(0xFF424752),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                 'Login',
                                      (route) => false,
                                );
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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