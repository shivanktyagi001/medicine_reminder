import 'package:equatable/equatable.dart';

abstract class AddMedicineState extends Equatable{
  @override
  List<Object?>get props => [];
}
class AddMedicineInitial extends AddMedicineState{}
class AddMedicineLoading extends AddMedicineState{}
class AddMedicineSuccess extends AddMedicineState{}
class AddMedicineError extends AddMedicineState{
  final String err;
  AddMedicineError(this.err);
  @override
  List<Object?>get props => [err];
}