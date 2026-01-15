import 'package:equatable/equatable.dart';

abstract class AddMedicineEvent extends Equatable{
  @override
  List<Object?> get props=>[];
}
class SubmitMedicineEvent extends AddMedicineEvent{
  final String name;
  final String dose;
  final DateTime time;
  SubmitMedicineEvent(this.name,this.time,this.dose);
}