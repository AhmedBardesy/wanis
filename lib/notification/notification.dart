

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServicesHelper {
  ///this is a private named constructor so no one can make new objects"only have one object named instance"
  NotificationServicesHelper._();

  ///made only one static object to be seen
  static final NotificationServicesHelper instance =
      NotificationServicesHelper._();
  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();
  static String cancelActionButtonId = "cancel";
  static String doneActionButtonId = "done";
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
      
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: backgroundHandler,
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onBackgroundResponse,
      onDidReceiveNotificationResponse: onForegroundResponse,
    );
  }

  static void backgroundHandler(
      int id, String? title, String? body, String? payload) async {
    debugPrint("Samuel Adel");
  }

  static onBackgroundResponse(NotificationResponse notificationResponse) async {
    debugPrint("Samuel Adel BackGround");
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        selectNotificationStream.add(notificationResponse.payload);
        break;
      case NotificationResponseType.selectedNotificationAction:
        if (notificationResponse.actionId == cancelActionButtonId) {
          selectNotificationStream.add(notificationResponse.payload);
        }

        break;
    }
  }

  static onForegroundResponse(NotificationResponse notificationResponse) async {
    debugPrint("Samuel Adel ForeGround");
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        selectNotificationStream.add(notificationResponse.payload);
        break;
      case NotificationResponseType.selectedNotificationAction:
        if (notificationResponse.actionId == cancelActionButtonId) {
        } else if (notificationResponse.actionId == doneActionButtonId) {
          debugPrint("Done pressed");
        }
        break;
    }
  }

  notificationDetails({required bool vibrate}) {
    final Int32List additionalFlags = Int32List(1);

    additionalFlags[0] = 4;

    final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 4000;
    vibrationPattern[2] = 4000;
    vibrationPattern[3] = 4000;
    return NotificationDetails(
        android: AndroidNotificationDetails(
          category: AndroidNotificationCategory.alarm,
          showWhen: true,
          autoCancel: false,
          enableLights: true,
          priority: Priority.max,
          'channelId',
          'channelName',
          audioAttributesUsage: AudioAttributesUsage.alarm,
          vibrationPattern: vibrationPattern,
          additionalFlags: additionalFlags,
          importance: Importance.max,
          sound: const RawResourceAndroidNotificationSound('alarm'),
          enableVibration: vibrate,
          ongoing: true,
          playSound: true,
          timeoutAfter: 300000,
          actions: <AndroidNotificationAction>[
            // AndroidNotificationAction(
            //   cancelActionButtonId,
            //   "Can't do it now!",
            //   cancelNotification: true,
            //   showsUserInterface: true,
            // ),
            AndroidNotificationAction(
              doneActionButtonId,
              'Done',
              cancelNotification: true,
              showsUserInterface: true,
            ),
          ],
        ),
        iOS: const DarwinNotificationDetails());
  }

  // Future<void> showNotification(
  //         {int id = 0, String? title, String? body, String? payload}) async =>
  //     notificationsPlugin.show(id, title, body, await notificationDetails());
  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  /// plans alarm
  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      required bool vibrate,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        await notificationDetails(vibrate: vibrate),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  /// daily routine alarm
  Future dailyRoutine(
      {int id = 0,
      String? title,
      String? body,
      required bool vibrate,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        await notificationDetails(vibrate: vibrate),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
