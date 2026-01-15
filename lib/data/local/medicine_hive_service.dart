import 'package:hive/hive.dart';
import 'package:medicine_reminder/data/model/medicine_model.dart';
class MedicineHiveService{
   static const String _boxName = 'medicines';
   Box<MedicineModel>get _box => Hive.box<MedicineModel>(_boxName);
   List<MedicineModel>getAllMedicine(){
     return _box.values.toList();
   }
   Future<void> addMedicine(MedicineModel model) async{
     await _box.add(model);
   }
   Future<void> deleteMedicine(MedicineModel model) async{
     await model.delete();
   }
}