
import 'package:expiration_final/services/local_notification_service.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  late final LocalNotificationService service;

  @override
  void initState(){
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () async{
          await service.showScheduledNotification(id: 0, title: 'notification', body: 'notificationbody', seconds: 5);
        }, child: Text('notif with payload'))
      ),
    );
  }
}