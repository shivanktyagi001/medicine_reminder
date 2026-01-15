import 'package:equatable/equatable.dart';
import 'package:medicine_reminder/data/model/medicine_model.dart';
abstract class HomeState extends Equatable{
  const HomeState();
  @override
  List<Object?> get props => [];

}
class MedicineLoadingState extends HomeState{}
class MedicineEmptyState extends  HomeState{}
class MedicineLoadedState extends HomeState{
  final List<MedicineModel>medicines;
  const MedicineLoadedState(this.medicines);
  @override
  List<Object?> get props =>[medicines];
}