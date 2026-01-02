import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map; //เป็นการรับค่าเข้ามา โดยรับค่าที่ได้ออกมาจาก choose_location
    print('data: $data');
    print('location: ${data['location']}');
    print('isDaytime: ${data['isDaytime']}');
    print('day img: ${data['day']}');
    print('night img: ${data['night']}');


    //set background
    String bgImage = data['isDaytime'] ? data['day']: data['night'];
    Color bgColor = data['isDaytime'] ? Color.fromARGB(255, 185, 245, 204) : Color.fromARGB(
        255, 225, 201, 255);
    Color? fontColor = data['isDaytime'] ? Colors.black87 : Colors.white;

    return Scaffold(
      backgroundColor: Colors.pinkAccent[50],
      appBar: AppBar(
        title: Text(
            'HOME',
          style: TextStyle(
            fontFamily: 'Caveat-VariableFont_wght',
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
                opacity: 0.7, // ทำให้ภาพจาง
            )
          ),
          child:Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =  await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location' : result['location'],
                        'isDaytime' : result['isDaytime'],
                        'flag' : result['flag'],
                        'day' : result['day'],
                        'night' : result['night']
                      };
                    });
                  },
                  label: Text(
                      'Location',
                      style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  icon: Icon(
                      Icons.location_on_rounded,
                      size: 18,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: fontColor, // ใส่สี

                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                          color: fontColor,
                          fontSize: 40,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ChangaOne-Italic'
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data['time'],
                  style: TextStyle(
                      fontSize: 60,
                      color: fontColor
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
