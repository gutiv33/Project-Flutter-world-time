import 'package:flutter/material.dart';
import 'package:flutter_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();

}


class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> listLocation = [
  WorldTime(location: "Zurich", flag: 'Switzerland', url: 'Zurich',day: 'day.jpg',night: 'Night-01.jpg'),
  WorldTime(location: "Paris", flag: 'France', url: 'Paris',day: 'day-01.jpg',night: 'Night-02.jpg'),
  WorldTime(location: "Athens", flag: 'Greece', url: 'Athens',day: 'day-022.jpg',night: 'Night-03.jpg'),
  WorldTime(location: "Berlin", flag: 'Germany', url: 'Berlin',day: 'day-033.jpg',night: 'Night-04.jpg'),
  WorldTime(location: "Prague", flag: 'Czech_Republic', url: 'Prague',day: 'day-04.jpg',night: 'Night-05.jpg')
  ];

  void updateTime(index) async {
    WorldTime instance = listLocation[index];
    await instance.getTime();

    //navigate to home screen
    Navigator.pop(context,{  //ปิดหน้าปัจจุบัน แล้วกลับไปหน้าก่อนหน้า
      'location': instance.location,
      "flag" : instance.flag,
      'time' : instance.time,
      'isDaytime' : instance.isDaytime,
      'day':instance.day,
      'night':instance.night
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("build function");
    return Scaffold(
      backgroundColor: Colors.amberAccent[50],
      appBar: AppBar(
        title: Text(
            'CHOOSE A LOCATION',
            style: TextStyle(
              fontFamily: 'Caveat-VariableFont_wght',
              fontWeight: FontWeight.bold
            ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[200],
        elevation: 0.0,
      ),
    body: ListView.builder(
        itemCount: listLocation.length,
        itemBuilder: (context,index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
              child: Card(
                color: Colors.pinkAccent[100],
                child: ListTile(
                  onTap: () {
                     updateTime(index);
                  },
                  title: Text(
                      listLocation[index].location,
                     //   style: TextStyle(
                     //      fontFamily: 'ChangaOne-Italic',
                     //       fontSize: 18,
                     // ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${listLocation[index].flag}.jpg'),
                  ),
                ),
              ),
          );
        },
      ) ,
    );
  }
}








//เพิ่มเติม
// class _ChooseLocationState extends State<ChooseLocation> {
//
//   int counter = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     print("initState function");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("build function");
//     return Scaffold(
//       backgroundColor: Colors.amberAccent[100],
//       appBar: AppBar(
//         title: Text('CHOOSE A LOCATION'),
//         centerTitle: true,
//         backgroundColor: Colors.orange[100],
//         elevation: 0.0,
//       ),
//       body: ElevatedButton( // เมื่อมีการกดฟังก์ชัน bulid() จะทำงาน เเต่ในฟังก์ชัน initState() ไม่ทำงาน
//         onPressed: () {
//           setState(() {
//             counter += 1;
//           });
//         },
//         child: Text('counter is: $counter'),
//       ),
//     );
//   }
// }




//-----------------------------------------------------------------------------------------------------------------------------------------------

// class _ChooseLocationState extends State<ChooseLocation> {
//
//   void getdata() async{
//
//     // simulate network request for a username
//     String username = await Future.delayed(Duration(seconds: 3),() {
//       return 'snow';
//     });
//
//     // simulate network request to get bio of the username
//     String bio = await Future.delayed(Duration(seconds: 2),() {
//       return 'cat';
//     });
//
//     print("$username - $bio");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getdata();
//     print('hey there');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("build function");
//     return Scaffold(
//       backgroundColor: Colors.amberAccent[100],
//       appBar: AppBar(
//         title: Text('CHOOSE A LOCATION'),
//         centerTitle: true,
//         backgroundColor: Colors.orange[100],
//         elevation: 0.0,
//       ),
//
//     );
//   }
// }

//ผลลัพธ์ -> D/WindowOnBackDispatcher( 4781): setTopOnBackInvokedCallback (unwrapped): android.app.Activity$$ExternalSyntheticLambda0@e7b3426
// I/flutter ( 4781): hey there
// I/flutter ( 4781): build function
// D/WindowOnBackDispatcher( 4781): setTopOnBackInvokedCallback (unwrapped): io.flutter.embedding.android.FlutterActivity$1@1dfdc5
// I/flutter ( 4781): snow - cat


// ---------------------------------------------------------------------------------------------------------------------------------------------


// State<ChooseLocation> createState() => _ChooseLocationState(); เเบบที่ 1
// _ChooseLocationState createState() => _ChooseLocationState(); --> แบบที่ 2

// | ประเด็น     | แบบที่ 1                    | แบบที่ 2              |
// | ----------- | --------------------------- | --------------------- |
// | การทำงาน    | ✅ เหมือนกัน                 | ✅ เหมือนกัน           |
// | Type safety | ✅ ดีกว่า                    | ⚠️ น้อยกว่า           |
// | แนวปฏิบัติ  | ⭐ แนะนำ                     | ใช้ได้ แต่ไม่ค่อยนิยม |
// | ความชัดเจน  | ชัดว่าเป็น State ของ Widget | ผูกกับ class โดยตรง   |