
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notification = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const ensureInitSettings =
    InitializationSettings(android: androidSettings);
    await _notification.initialize(ensureInitSettings);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    final androidPlugin =
    _notification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'medicine_channel',
      'Medicine Reminders',
      description: 'Notifies when it’s time to take medicine',
      importance: Importance.max,
    );

    await androidPlugin?.createNotificationChannel(channel);
  }

  Future<void> scheduleMedicineNotification({
    required int id,
    required String medicineName,
    required String dose,
    required DateTime schedulesTime,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'medicine_channel',
      'Medicine Reminders',
      channelDescription: 'Notifies when it’s time to take medicine',
      importance: Importance.max,
      priority: Priority.high,
    );

    final details = NotificationDetails(android: androidDetails);

    await _notification.zonedSchedule(
      id,
      'Medicine Reminder',
      'Time to take $medicineName ($dose)',
      tz.TZDateTime.from(schedulesTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }


  Future<void> cancelNotification(int id)async{
    await _notification.cancel(id);
}



}