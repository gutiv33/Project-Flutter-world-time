import 'package:flutter/material.dart';
import 'package:flutter_time/services/world_time.dart';
import 'package:lottie/lottie.dart';


class Welcome extends StatefulWidget {

  @override
  State<Welcome> createState() => _WelcomeState();

}


class _WelcomeState extends State<Welcome> {

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: "Zurich", flag: 'Switzerland', url: 'Zurich',day: 'day.jpg',night: 'Night-01.jpg');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location': instance.location,
      "flag" : instance.flag,
      'time' : instance.time,
      'isDaytime' : instance.isDaytime,
      'day' : instance.day,
      'night' : instance.night
    });

  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     setupWorldTime();
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 162, 213, 248),
      appBar: AppBar(
        title: Text(
            'WELCOME',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Caveat-VariableFont_wght'
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 81, 149, 229),
      ) ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets10.lottiefiles.com/packages/lf20_2LdLki.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),

            ElevatedButton.icon(
                onPressed: () {
                  setupWorldTime();
                },
               icon: Icon(
                   Icons.home,
                    size: 50,
               ),
              label: Text(
                'HOME',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily:'AlfaSlabOne-Regular'
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/map');
                },
                icon: Icon(
                    Icons.map,
                    size: 50,
                ),
                label: Text(
                    "Map",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily:'AlfaSlabOne-Regular'
                  ),
                ),
            )
          ],
        ),

      ),

      );

  }
}
