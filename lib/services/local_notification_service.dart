import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
      '@drawable/Iconkitchen-Output',
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      // deins naman nagana na toh, T^T
      // onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channelId', 'channelName', channelDescription: 'description',
    importance: Importance.max,
    priority: Priority.max,
    playSound: true);

    return const NotificationDetails(
      android: androidNotificationDetails
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async{
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  // for sched notif
  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required int seconds
  }) async{
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(id, title, body, 
    // modify add the exp dates
    tz.TZDateTime.from(DateTime.now().add(Duration(seconds: seconds)), tz.local), 
    details,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload){
    print('id $id');
  }

  Future<void> onSelectNotification(String? payload) async {
    print('Tapped on notification with payload: $payload');

  }
}
