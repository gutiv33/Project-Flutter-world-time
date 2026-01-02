import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
 
   @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setup()  {
 //    WorldTime instance = WorldTime(location: "Zurich", flag: 'Switzerland', url: 'Zurich',day: 'day.jpg',night: 'Night-01.jpg');
 //    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/welcome');
    //    ,arguments: {
 //      'location': instance.location,
 //      "flag" : instance.flag,
 //      'time' : instance.time,
 //      'isDaytime' : instance.isDaytime,
 //      'day' : instance.day,
 //      'night' : instance.night
 //    });
 //
  }
 //
 @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setup();
    });
 //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SpinKitPumpingHeart(
          color: Color.fromARGB(255, 244, 83, 176),
          size: 150,
        ),
      ),
    );
  }
}




//เพิ่มเติม
// void getdata() async{
//
//   final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
//   final response = await get(url);
//
//   // Response response = await get('https://jsonplaceholder.typicode.com/todos/1');
//   // print(response.body); -> ข้อมูลที่ได้ออกมาจะอยู่ในรูปของ obj
//
//   Map data = jsonDecode(response.body); //-> ข้อมูลจะได้ออกมาในรูป map
//   print(data);
//   print(data['title']);
// }


// WidgetsBinding.instance.addPostFrameCallback((_) { ... });
// Flutter มี rendering pipeline คือ widget จะถูกสร้าง (build) และวาด (render) บนหน้าจอ
// บางครั้งเราต้องการให้โค้ด ทำงานหลังจาก widget วาดเสร็จแล้ว
// addPostFrameCallback ทำให้ callback ถูกเรียกหลังจาก frame ปัจจุบันวาดเสร็จ