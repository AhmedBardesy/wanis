// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app12_finalprojct/cubit/cubit_states.dart';
import 'package:app12_finalprojct/cubit/notifictaion_cubit.dart';
import 'package:flutter/material.dart';

import 'package:app12_finalprojct/models/medicine_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineDetails extends StatelessWidget {
  const MedicineDetails({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  final Medicine? medicine;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEBDCCD),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffEBDCCD),
            title: Text('Medicine Details',
                style: Theme.of(context).textTheme.headline1)),
        body: BlocConsumer<NotificationCubit, NotificationState>(
            listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      height: 300,
                      width: 200,
                      child: Image.asset('assets/pharmacy-removebg-preview.png')),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        MainInfoTab(
                            fieldTitle: 'Medicine Name',
                            fieldInfo: '${medicine!.MedicineName}'),
                        MainInfoTab(
                            fieldTitle: 'Dosage', fieldInfo: '${medicine!.dose}'),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: ExtendInfoTab(
                    fieldTitle: 'Start Time',
                    fieldInfo:
                        '${medicine!.starttime!.substring(0, 2)}:${medicine!.starttime!.substring(2)}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: ExtendInfoTab(
                    fieldTitle: 'Medicine Type',
                    fieldInfo: '${medicine!.medicineType}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: ExtendInfoTab(
                    fieldTitle: 'Interval', fieldInfo: '${medicine!.interval}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: SizedBox(
                      height: 60,
                      width: 320,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xffca7c6c),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () async {
                          openAlertBox(context, medicine!);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white,fontFamily: 'Acme'),
                        ),
                      )),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  const MainInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 200,
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fieldTitle, style: Theme.of(context).textTheme.headline5),
                Text(fieldInfo, style: Theme.of(context).textTheme.headline6)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExtendInfoTab extends StatelessWidget {
  const ExtendInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fieldTitle, style: Theme.of(context).textTheme.headline5),
          Text(fieldInfo, style: Theme.of(context).textTheme.headline6)
        ],
      ),
    );
  }
}

openAlertBox(
    BuildContext context,
    //String title,
    Medicine medicine) {
  return showDialog(
    context: context,
    builder: (context) {
      return BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {
        // TODO: implement listener
      }, builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          title: const Text('Delete this Reminder? '),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                )),
            TextButton(
                onPressed: () {
                  BlocProvider.of<NotificationCubit>(context)
                      .deleteMedicine(medicine);
                  // Navigator.pop(context);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('OK', style: TextStyle(color: Colors.red))),
          ],
        );
      });
    },
  );
}
