import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/core/services/notification_services.dart';
import 'package:medicine_reminder/data/local/medicine_hive_service.dart';
import 'package:medicine_reminder/data/model/medicine_model.dart';
import 'package:medicine_reminder/features/add_medicine/bloc/add_medicine_event.dart';
import 'package:medicine_reminder/features/add_medicine/bloc/add_medicine_state.dart';

class AddMedicineBloc extends Bloc<AddMedicineEvent,AddMedicineState>{
  final MedicineHiveService hiveService;
  AddMedicineBloc(this.hiveService):super(AddMedicineInitial()){
    on<SubmitMedicineEvent>(_submit);
  }
  Future<void>_submit(
      SubmitMedicineEvent event,
      Emitter<AddMedicineState>emit,
      )async{
    if(event.name.isEmpty || event.dose.isEmpty){
      emit(AddMedicineError("All fields are required"));
      return;
    }
    emit(AddMedicineLoading());
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;;
    final medicine = MedicineModel(

        name: event.name,
        dose: event.dose,
        time: event.time,
        notificationId: id);
    await hiveService.addMedicine(medicine);
    await NotificationService.instance.scheduleMedicineNotification(
        id: id,
        medicineName:event.name,
        dose: event.dose,
        schedulesTime: event.time);
    emit(AddMedicineSuccess());
  }
}