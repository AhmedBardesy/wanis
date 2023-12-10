// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:app12_finalprojct/models/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app12_finalprojct/cubit/cubit_states.dart';
import 'package:app12_finalprojct/cubit/notifictaion_cubit.dart';
import 'package:app12_finalprojct/pages/searhpage.dart';

import '../notification/notification.dart';

String? timeee;

class AlarmScreen extends StatelessWidget {
  AlarmScreen({super.key});
  TextEditingController namecontroler = TextEditingController();
  TextEditingController dosage = TextEditingController();
  TextEditingController starttime = TextEditingController();
  TextEditingController medicinetype = TextEditingController();
  TextEditingController interval = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final Medicine medicine;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEBDCCD),
        appBar: AppBar(
          backgroundColor: const Color(0xffEBDCCD),
          elevation: 0,
          actions: [
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/thelogo.jpg')))
          ],
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            // listener: (context, state) {},
            builder: (context, state) {
          //var medicinelist = BlocProvider.of <NotificationCubit>(context).MedicinesList;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                 Text(
                  'Set Alarm',
                  style: Theme.of(context).textTheme.headline4,
                 
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputField(
                              hit: 'Medicine Name',
                              controller: namecontroler,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InputField(
                              hit: "Dosage",
                              controller: dosage,
                              keyboardtype: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                         
                            select_time(),
                            const SizedBox(
                              height: 30,
                            ),
                            InputField(
                              hit: 'Medicine Type',
                              controller: medicinetype,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InputField(
                              hit: 'Interval',
                              controller: interval,
                              keyboardtype: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GradientButtonFb1(
                              color: Color(0xffca7c6c),
                              text: 'Sumbit',
                              onPressed: () {
                                List<int> intIDs = makeIDs(
                                  24 / int.parse(interval.text),
                                );

                                List<String> notificationIDs =
                                    intIDs.map((i) => i.toString()).toList();
                                print(
                                    '****************************Notification IDs*********************${notificationIDs}');
                                var time =
                                    BlocProvider.of<NotificationCubit>(context)
                                        .selectedtime;

                                if (_formKey.currentState!.validate()) {
                                  Medicine newenty = Medicine(
                                      notificationIDs: notificationIDs,
                                      MedicineName: namecontroler.text,
                                      dose: int.parse(dosage.text),
                                      starttime: timeee,
                                      medicineType: medicinetype.text,
                                      interval: int.parse(interval.text));
                                  BlocProvider.of<NotificationCubit>(context)
                                      .saveMedicines(newenty);

                                  _createMedicineAlarm(newenty);
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];

    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }

    return ids;
  }

  void _createMedicineAlarm(Medicine medicine) {
    // int hour=int.parse(startTimem);
    String dateTime = DateTime.now().toString();
    List dateTime2 = dateTime.split(" ");
    List dateTime3 = dateTime2[0].split("-");

    print("8******************dateTime**************${dateTime}");
    print("8******************dateTime33**************${dateTime3}");

    DateTime initialtime = DateTime(
        int.parse(dateTime3[0]),
        int.parse(dateTime3[1]),
        int.parse(dateTime3[2]),
        int.parse(medicine.starttime!.substring(0, 2)),
        int.parse(medicine.starttime!.substring(2)));
    // print(initialtime);
    double lenghtt = 24 / medicine.interval!;
    int increment = 0;
    for (int i = 0; i < lenghtt; i++) {
      print("8*************************initialtime*******${initialtime}");
      print(
          "8*************************medicine.interval*******${medicine.interval}");
      print(
          "8*************************medicine.MedicineName*******${medicine.MedicineName}");
      print("8*************************medicine.dose*******${medicine.dose}");
      print(
          "8*************************medicine.notificationIDs*******${medicine.notificationIDs}");

      print(
          "8*************************parse medicine notification index*******${int.parse(medicine.notificationIDs![i])}");
      NotificationServicesHelper.instance.dailyRoutine(
          id: int.parse(medicine.notificationIDs![i]),
          title: "Time for ${medicine.MedicineName} dosage",
          body: "yor dosage ${medicine.dose} mg" as String,
          vibrate: true,
          scheduledNotificationDateTime:
              initialtime.add(Duration(hours: increment)));
      print(
          "8*************************initial time increment*******${initialtime.add(Duration(hours: increment))}");
      increment += medicine.interval!;
    }
  }
}

class InputField extends StatelessWidget {
  const InputField({Key? key, this.controller, this.hit, this.keyboardtype})
      : super(key: key);
  final TextEditingController? controller;
  final String? hit;
  final TextInputType? keyboardtype;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Requied Field';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        label: Text(hit!,style: Theme.of(context).textTheme.headline3,),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

class select_time extends StatefulWidget {
  const select_time({
    super.key,
  });

  @override
  State<select_time> createState() => _select_timeState();
}

class _select_timeState extends State<select_time> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);

  bool _clicked = false;

  Future<TimeOfDay?> _sselectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
      useRootNavigator: false,
    );

    if (picked != null && picked != _time) {
      setState(() {
        print('***************************************************${picked}');
        _time = picked;

        timeee = convertTime(_time.hour.toString()) +
            convertTime(_time.minute.toString());
        //0320 => 03:20
        print(
            '********************timeee*******************************${timeee}');
        _time = picked;
        _clicked = true;
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 15,
      ),
      child: SizedBox(
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xffca7c6c),
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            _sselectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? 'select time'
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }

  String convertTime(String minute) {
    if (minute.length == 1) {
      return "0$minute";
    } else {
      return minute;
    }
  }
}
