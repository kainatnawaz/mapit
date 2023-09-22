import 'package:mapit/mapit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GoogleMapScreen(
            // selectedLocationLat:51.5072 ,
            // selectedLocationLng:0.1276 ,
            // markerImage: "assets/marker.png",
            onPressBack: (){
              Navigator.pop(context);
            },
            address: (val){

            }, mapApiKey: 'AIzaSyB3-PXBvW4UuH10ZRBY7kd20EFcxDZksQU',
          )),
    );
  }
}
