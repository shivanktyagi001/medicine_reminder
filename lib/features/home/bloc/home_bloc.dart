import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:medicine_reminder/data/local/medicine_hive_service.dart';
class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final MedicineHiveService hiveService;
  HomeBloc(this.hiveService):super(MedicineLoadingState()){
    on<LoadMedicineEvent>(_loadMedicines);
    on<RefreshMedicineEvent>(_loadMedicines);
    on<DeleteMedicineEvent>(_deleteMedicine);
  }
  Future<void> _deleteMedicine(DeleteMedicineEvent event,
      Emitter<HomeState>emit
      ) async{
     if(state is MedicineLoadedState){
       final currentState = state as MedicineLoadedState;
       final updateList = List.of(currentState.medicines)..removeWhere((m) => m.notificationId == event.model.notificationId);
       if(updateList.isEmpty){
         emit(MedicineEmptyState());
       }else{
         emit(MedicineLoadedState(updateList));
       }
       await hiveService.deleteMedicine(event.model);
     }
  }
  void _loadMedicines(
      HomeEvent event,
      Emitter<HomeState>emit,
      ){
    final medicines = hiveService.getAllMedicine();
    if(medicines.isEmpty){
      emit(MedicineEmptyState());
      return;
    }
    medicines.sort((a,b) =>a.time.compareTo(b.time));
    emit(MedicineLoadedState(medicines));
  }
}