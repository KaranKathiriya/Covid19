import 'package:flutter/material.dart';
import 'package:indiacovid19/screens/home/home.dart';
import 'package:indiacovid19/services/notification.dart';

void main() => runApp(MyApp());

const myColor = Colors.brown;

class MyApp extends StatelessWidget {
  @override
  void initState() {
    PushNotificationService();
  }

  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'IndiaCovid19',
          theme: ThemeData(primarySwatch: myColor),
          home: Home()),
    );
  }
}
