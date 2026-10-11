import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmService {
  static final FlutterLocalNotificationsPlugin notifications =
  FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await notifications.initialize(
      settings: settings,
    );

    final AndroidFlutterLocalNotificationsPlugin? android =
    notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();

    _initialized = true;
  }

  static Future<void> setAlarm({
    required int id,
    required String recipeName,
    required DateTime dateTime,
  }) async {
    await initialize();

    final tz.TZDateTime scheduledDate =
    tz.TZDateTime.from(dateTime, tz.local);

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      throw Exception('Please select a future time.');
    }

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'meal_alarm_channel',
      'Meal Alarms',
      channelDescription: 'Alarms for meal reminders',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidDetails,
    );

    await notifications.zonedSchedule(
      id: id,
      title: '🍔 Time to Eat!',
      body: 'Your $recipeName is ready to eat.',
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode:
      AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelAlarm(int id) async {
    await initialize();

    await notifications.cancel(
      id: id,
    );
  }
}