// Import necessary packages
import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

// Define a StatefulWidget called Home
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Initialize an empty map to hold data
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // Check if data is not empty, otherwise get arguments from the previous route
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // Set the background image based on whether it's daytime or nighttime based on the chosen location
    String bgImage = data['isDaytime'] == null ? 'day.png' : 'night.png';
    // Set the background color based on whether it's daytime or nighttime
    Color bgColor =
        data['isDaytime'] == null ? Colors.blue : Colors.indigo[700];
    // Return a Scaffold widget that defines the structure of the app's UI
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                // Define a TextButton that navigates to the location route when pressed
                TextButton(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    // If result is not null, update the state with the new data
                    if (result != null) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag']
                        };
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                      ),
                      Text(
                        'Edit Location',
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                // Add some vertical spacing
                SizedBox(height: 20.0),
                //Display the location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Add some vertical spacing
                SizedBox(height: 20.0),
                // Display the time
                Text(data['time'],
                    style: TextStyle(fontSize: 66.0, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
