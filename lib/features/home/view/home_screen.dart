import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/data/local/medicine_hive_service.dart';
import 'package:medicine_reminder/features/add_medicine/view/add_medicine_screen.dart';
import 'package:medicine_reminder/features/home/bloc/home_bloc.dart';
import 'package:medicine_reminder/features/home/bloc/home_event.dart';
import 'package:intl/intl.dart';
import '../../add_medicine/bloc/add_medicine_bloc.dart';
import '../bloc/home_state.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Reminder"),
      ),
      body: BlocBuilder<HomeBloc,HomeState>(
          builder: (context,state){
            if(state is MedicineLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is MedicineEmptyState){
              return const Center(
                child:  Text("No Medicine added yet"),
              );
            }
            if(state is MedicineLoadedState){
              return ListView.builder(
                itemCount: state.medicines.length,
                  itemBuilder: (context,index){
                        final med = state.medicines[index];
                        return Dismissible(
                          key:ValueKey(med.notificationId),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete,color: Colors.white,),
                          ),
                          onDismissed: (_){
                            context.read<HomeBloc>().add(DeleteMedicineEvent(med));
                          },
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              leading: const Icon(Icons.mediation,color: Colors.teal,),
                                title: Text(med.name,style: const TextStyle(fontWeight: FontWeight.bold),),
                                subtitle:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text("Dose: ${med.dose}"),
                                    Text("Time: ${DateFormat.jm().format(med.time)}"),
                                  ],
                                ),
                            ),
                          ),
                        );
                  },

              );
            }
            return const SizedBox();
          },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        final added  = await Navigator.push(context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => AddMedicineBloc(MedicineHiveService()),
                child: const AddMedicineScreen(),
              ),
            ),);
        if(added == true){
          context.read<HomeBloc>().add(RefreshMedicineEvent());
        }
      },
        child: const Icon(Icons.add),
      ),
    );
  }
}
