import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/data/local/medicine_hive_service.dart';
import 'package:medicine_reminder/features/home/bloc/home_bloc.dart';
import 'package:medicine_reminder/features/home/bloc/home_event.dart';
import '../features/home/view/home_screen.dart';
import 'theme.dart';
class MedicineApp extends StatelessWidget {
  const MedicineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(MedicineHiveService())..add(LoadMedicineEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
