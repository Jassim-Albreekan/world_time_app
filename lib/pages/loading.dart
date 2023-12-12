// Import necessary packages
import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // Define a function to setup world time
  void setupWorldTime() async {
    // Create an a varible called instance of WorldTime
    WorldTime instance = WorldTime(
        location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    // getting the current time
    await instance.getTime();
    // Navigate to the home route and pass the necessary arguments
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime
    });
  }

  // Override the initState method to setup world time when the widget is initialized
  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget that defines the structure of the app's UI
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            // Display a loading widget from a package
            child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
