import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/data/local/medicine_hive_service.dart';
import 'package:medicine_reminder/features/add_medicine/bloc/add_medicine_bloc.dart';
import 'package:medicine_reminder/features/add_medicine/bloc/add_medicine_event.dart';
import 'package:medicine_reminder/features/add_medicine/bloc/add_medicine_state.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _nameController = TextEditingController();
  final _doseConroller = TextEditingController();
  DateTime? _time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text('Add Medicine')
        ),
        body: BlocListener<AddMedicineBloc,AddMedicineState>(
            listener: (context,state){
              if(state is AddMedicineSuccess){
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text("Successfully Added Medicine to List",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                     backgroundColor: Colors.green,
                   )
                 );
                 Navigator.pop(context,true);
              }
              if(state is AddMedicineError){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.err,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      backgroundColor: Colors.red,
                    )
                );
              }

            },
            child:Padding(
                padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Medicine Name'),
                  ),
                  const SizedBox(height:12),
                  TextField(
                    controller: _doseConroller,
                    decoration: const InputDecoration(labelText: 'Dose'),
                  ),
                  const SizedBox(height:12),
                  ElevatedButton(
                      onPressed: ()async{
                        final picked = await showTimePicker(context: context, initialTime:TimeOfDay.now());
                        if(picked != null){
                          final now = DateTime.now();
                          setState(() {
                            _time = DateTime(
                              now.year,now.month,
                              now.day,picked.hour,picked.minute,
                            );
                          });

                        }
                      },
                      child: const Text('Pick Time')),
                  if (_time != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      "Reminder set for ${DateFormat.jm().format(_time!)}",
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const Spacer(),
                ElevatedButton(onPressed: (){
                       if(_time == null){
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('Please select time',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                             backgroundColor: Colors.red,
                           ),
                         );
                         return;
                       }
                       context.read<AddMedicineBloc>().add(
                         SubmitMedicineEvent(
                             _nameController.text,
                             _time!,
                             _doseConroller.text)
                       );
                    },
                    child: const Text('Save')),
                ],
              ),
            ) ,
        ),
    );
  }
}
