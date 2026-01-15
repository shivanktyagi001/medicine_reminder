import 'package:equatable/equatable.dart';
import 'package:medicine_reminder/app/app.dart';
import 'package:medicine_reminder/data/model/medicine_model.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();
  @override
  List<Object?>get props =>[];
}
class LoadMedicineEvent extends HomeEvent{}
class RefreshMedicineEvent extends HomeEvent{}
class DeleteMedicineEvent extends HomeEvent{
    final MedicineModel model;
    DeleteMedicineEvent(this.model);
    @override
  List<Object?>get props => [model];
}