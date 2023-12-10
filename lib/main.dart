import 'package:app12_finalprojct/cubit/notifictaion_cubit.dart';
import 'package:app12_finalprojct/pages/alarmpage.dart';
import 'package:app12_finalprojct/pages/dose_view.dart';
import 'package:app12_finalprojct/pages/searhpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification/notification.dart';

import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();

  await NotificationServicesHelper.instance.initNotification();
  tz.initializeTimeZones();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:  TextTheme(
              headline2: TextStyle(fontFamily: 'Acme',fontSize: 80,color: Colors.black),
              headline1: TextStyle(fontFamily: 'Acme',color: Colors.black,fontSize: 20),
              headline6: TextStyle(fontFamily: 'Acme',color: Color(0xffca7c6c),fontSize: 20),
              headline3: TextStyle(fontFamily: 'Acme',color: Colors.black.withOpacity(0.3),fontSize: 20,),
              headline4: TextStyle(fontFamily: 'Acme',color: Colors.black,fontSize: 50,),
              headline5: TextStyle(fontFamily: 'Acme',color: Colors.black,fontSize: 30,),
            ),
            primarySwatch: Colors.blue,
          ),
          home: const
           DoseView()
         
          // SearchScreen(),
          ),
    );
  }
}

