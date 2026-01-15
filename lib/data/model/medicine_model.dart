import 'package:hive/hive.dart';
part 'medicine_model.g.dart';
@HiveType(typeId:0)
class MedicineModel extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String dose;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  final int notificationId;

  MedicineModel({
    required this.name,
    required this.dose,
    required this.time,
    required this.notificationId
});

}
