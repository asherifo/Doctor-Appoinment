import 'package:doctor_appoinment/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/logic/auth_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => AuthCubit(),),
      ],
      child: MaterialApp(

        title: 'Doctor Appoinment',
        debugShowCheckedModeBanner: false,
        initialRoute:  'Splash',
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}

