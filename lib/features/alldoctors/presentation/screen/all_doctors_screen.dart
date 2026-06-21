import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:doctor_appoinment/features/alldoctors/data/repo.dart';

import 'package:doctor_appoinment/features/alldoctors/logic/cubit.dart';
import 'package:doctor_appoinment/features/alldoctors/logic/states.dart';
import 'package:doctor_appoinment/features/alldoctors/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/doctor_list.dart';
import '../widgets/filter.dart';

class FindDoctorScreen extends StatelessWidget {
  const FindDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllDoctorsCubit(doctorRepository: DoctorRepository())..getAllDoctors(),
      child: Scaffold(
        backgroundColor: AppColors.BackgroundColor, // لون خلفية رايق ونظيف
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Find a Doctor',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: Color(0xFF004B93),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 🔍 Search Bar (المعدل النظيف)
                const CustomSearchBar(),
                const SizedBox(height: 20),

                // Filter Chips
                const FilterChipsRow(),
                const SizedBox(height: 20),

                // Results Count text ديناميكي بيتأثر بالـ State
                BlocBuilder<AllDoctorsCubit, AllDoctorsState>(
                  builder: (context, state) {
                    int count = 0;
                    if (state is AllDoctorSuccessState) {
                      count = state.doctors.length;
                    }
                    return Text(
                      'Showing $count results for "Doctors"',
                      style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // 👥 Doctor List (المكان الموحد والوحيد لعرض الداتا)
                const DoctorList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}