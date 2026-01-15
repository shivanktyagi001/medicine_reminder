import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medicine_reminder/app/app.dart';
import 'package:medicine_reminder/core/services/notification_services.dart';
import 'package:medicine_reminder/data/model/medicine_model.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MedicineModelAdapter());
  await Hive.openBox<MedicineModel>('medicines');
  await NotificationService.instance.init();
  runApp(const MedicineApp());
}

