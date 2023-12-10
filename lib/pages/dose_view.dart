// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app12_finalprojct/cubit/cubit_states.dart';
import 'package:app12_finalprojct/cubit/notifictaion_cubit.dart';
import 'package:app12_finalprojct/pages/alarmpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/medicine_model.dart';
import 'medicine_details.dart';

class DoseView extends StatefulWidget {
  const DoseView({super.key});

  @override
  State<DoseView> createState() => _DoseViewState();
}
// old color Color.fromARGB(255, 212, 156, 52)
class _DoseViewState extends State<DoseView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEBDCCD),
        appBar: AppBar(
          backgroundColor:  Color(0xffEBDCCD),
          elevation: 0,
          actions: [
            Center(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset('assets/thelogo.jpg')))
          ],
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
          return FutureBuilder(
              future:
                 BlocProvider.of<NotificationCubit>(context).getMedicines(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ));
                } else if (snapshot.hasError) {
                  // Handle error if there's an issue retrieving data
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Display a message if there are no medicines
                  return Center(
                      child: Text(
                        
                          'No medicines available.  \n   Add New Medicine Down page.'
                          ,style: Theme.of(context).textTheme.headline3,
                          ));
                } else {
                  var medicinelist = snapshot.data!;
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: medicinelist.length,
                      itemBuilder: (context, index) {
                        return MedicineCard(
                          medicine: medicinelist[index],
                        );
                      });
                }
              });
        }),
        floatingActionButton: FloatingActionButton(
          //ca7c6c
          backgroundColor: Color(0xffca7c6c),
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlarmScreen(),
                ));
          },
        ),
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, @required this.medicine});
  final Medicine? medicine;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.blue,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MedicineDetails(
                      medicine: medicine,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xffca7c6c),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('assets/pharmacy-removebg-preview.png')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
              
              '${medicine!.MedicineName}',style: TextStyle(fontSize: 30),softWrap:false ,),
            ),
          ],
        ),
      ),
    );
  }
}
