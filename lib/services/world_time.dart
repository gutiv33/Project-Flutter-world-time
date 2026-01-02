import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

    late String location; //location name for the UI
    late String time; // the time in that location
    late String flag; // url to an assert flag icon
    late String url; // location url for api endpoint
    late bool isDaytime; // true or false if daytime or not
    late String day;
    late String night;

    WorldTime({required this.location,required this.flag,required this.url,required this.day,required this.night});

    Future<void> getTime() async { // เป็น Obj ที่แทนผลลัพธ์ที่กำลังทำงานอยู่ (Asynchonous operation เป็นการปล่อยคำสั่งที่ใช้เวลานานไปทำงานเบื้องหลัง แล้วทำงานอื่นต่อได้เลย)

      try {

        // make the request
        final link = Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=Europe/$url');
        final response = await get(link); // เป็นการบอกว่าให้ทำคำสั่งนี้ให้เสร็จก่อนแล้วค่อยไปทำคำสั่งถัดไป

        Map data = jsonDecode(response.body); //-> ข้อมูลจะได้ออกมาในรูป map

        //get properties from data
        String datetime = data['dateTime'];
        // print('DateTime :$datetime'); -> DateTime :2025-12-18T06:38:16.8823988

        //create DateTime object
        DateTime now = DateTime.parse(datetime); // เเปลงข้อมูลที่เป็น Obj ของ datatime ให้อยู่ในรูปแบบของ String
        // print('Now: $now');// -> Now: 2025-12-18 06:38:16.882398

        //set the time property
        // time = now.toString();

        isDaytime = now.hour > 6 && now.hour < 20 ? true:false;
        time = DateFormat.jm().format(now); // -> จัดการเวลาจาก 06:38:16.882398 ให้เป็น 06:38 AM

      }
      catch (e) {
        print('caught error: $e');
        time = 'could not get time data';
      }

    }
}





// เพิ่มเติม
// now.add(Duration(hours: 1));


//DateFormat.jm() เป็น Format String ที่ใช้กำหนดรูปแบบการแสดงผลวันที่และเวลาในโค้ดโปรแกรม โดยเฉพาะในภาษาหรือไลบรารีที่จัดการเรื่องวันที่และเวลา


//จะเข้า catch เมื่อเกิด exception เช่น
// - อินเทอร์เน็ตมีปัญหา / ต่อไม่ได้
// -  URL ผิดจน request ส่งไม่ได้
// - jsonDecode(response.body) → ถ้าเว็บส่งข้อมูลที่ ไม่ใช่ JSON
// -  DateTime.parse(datetime) → ถ้า dateTime เป็น null หรือรูปแบบผิด
