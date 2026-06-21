import 'package:doctor_appoinment/features/alldoctors/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        // بتبعت النص للـ Cubit والـ Debounce اللي عملناه هيهندل الباقي
        context.read<AllDoctorsCubit>().searchDoctors(value);
      },

      decoration: InputDecoration(
        label: Text('Enter Doctor Name',),
        prefixIcon: const Icon(Icons.search),
        disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:  BorderSide(color: Colors.yellow),
      ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Colors.green),
        ),


        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}