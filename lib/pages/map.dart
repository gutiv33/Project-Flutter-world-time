import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  String _mapType = 'streets';
  LatLng _currentLoation_load = LatLng(13.7563,100.5081); //พิกัดเริ่มตัน
  late final MapController _mapController;

  String _currentLocation = '' ;  //ตัวแปรตำเเหน่งปัจจุบัน
  double lat = 0.0; //กำหนดละติจูด
  double long = 0.0; //กำหนดลองจิจูด

  // ฟังก์ชันคืนค่า URL ของ TileLayer
  String getTileLayerUrl() {
    return _mapType = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation(); //ฟังก์ชันในการดึงค่าตำเเหน่งปัจจุบัน
  }

  // ฟังก์ชันดึงตำแหน่งปัจจุบัน
  Future<void> _getCurrentLocation() async{
    bool serviceEnabled; // ตัวแปรเก็บค่าการเปิด Location Services
    LocationPermission permission; // ตัวแปรเก็บค่าสิทธิ์การเข้าถึงตำเเหน่ง

    //ตรวจสอบว่า Location Services เปิดอยู่หรือไม่
    serviceEnabled = await Geolocator
       .isLocationServiceEnabled();

    if (!serviceEnabled) {

      // await Geolocator.openLocationSettings();
      // return Future.error()
      //ถ้า location services ปิดอยู่
      setState(() {
        _currentLocation = "Location service ปิดอยู่ กรุณาเปิดใช้งาน"; //กำหนดข้อความเเจ้งเตือน
        _showAlertDialog(
          context,"ข้อผิดพลาด",_currentLocation // แสดง Dialog เเจ้งเตือน
        );
      });
      return;
    }

    //ตรวจสอบการเข้าถึงตำเเหน่ง
    permission = await Geolocator.checkPermission(); //ตรวจสอบสิทธิ์การเข้าถึงตำแหน่ง

    if (permission == LocationPermission.denied){
      //ถ้าสิทธิ์การเข้าถึงตำแหน่งถูกปฎิเสธ
      permission = await Geolocator.requestPermission(); //ขอสิทธิ์การเข้าถึงตำเเหน่ง

      if (permission == LocationPermission.denied) {
        //ถ้าสิทธิ์การเข้าถึงตำเเหน่งถูกปฎิเสธ
        setState(() {
          _currentLocation = "สิทธิ์การเข้าถึงตำเเหน่งถูกปฎิเสธ"; //กำหนดข้อความการเเจ้งเตือน
          _showAlertDialog(context, "ข้อความผิดพลาด", _currentLocation); //เเสดง Dialog การเเจ้งเตือน
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //ถ้าสิทธิ์การเข้าถึงตำเเหน่งถูกปฎิเสธถาวร
      setState(() {
        _currentLocation = "สิทธิ์การเข้าถึงถูกปฎิเสธถาวร ไม่สามารถเข้าถึงได้"; //กำหนดข้อความการเเจ้งเตือน
        _showAlertDialog(context, "ข้อความผิดพลาด", _currentLocation); //เเสดง Dialog การเเจ้งเตือน
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      //ดึงตำแหน่งปัจจุบัน
      // desiredAccuracy: LocationAccuracy.high, -> มีการถูกขีดฆ่าที่ desiredAccuracy เนื่องจากในเวอร์ชันปัจจุบันเลิกใช้งานเเล้ว
        locationSettings:LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
    );
    setState(() {
      lat = position.latitude; //กำหนดค่าละติจูด
      long = position.longitude; //กำหนดค่าลองจิจูด
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Map',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              // fontFamily: 'Caveat-VariableFont_wght',
              fontSize: 25,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,

      ) ,
      floatingActionButton: SpeedDial(
        icon:Icons.category_outlined,
        activeIcon:Icons.close,
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.lightGreen,
            child: Icon(Icons.exit_to_app , color: Colors.white,size: 20),
            label: 'ออกจากหน้านี้',
            labelBackgroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.pink[300],fontSize: 16),
            onTap: () {
              Navigator.pushNamed(context, '/welcome');
            },
          ),

          SpeedDialChild(
            backgroundColor: Colors.lightGreen,
            child: Icon(Icons.zoom_in , color: Colors.white,size: 20),
            label: 'แผนที่เต็มจอ',
            labelBackgroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.pink[300],fontSize: 16),
            onTap: () => Navigator.pushNamed(
                context,'/zoom')
          ),

          SpeedDialChild(
            backgroundColor: Colors.lightGreen,
            child: Icon(Icons.my_location , color: Colors.white,size: 20),
            label: 'ตำเเหน่งปัจจุบัน',
            labelBackgroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.pink[300],fontSize: 16),
            onTap: () {
              setState(() {
                _currentLoation_load = LatLng(lat, long);
              });
              // เลื่อนแผนที่ไปตำแหน่งปัจจุบันตอนโหลดครั้งแรก
              _mapController.move(_currentLoation_load, 16.0);
            },
          ),

        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLoation_load, //ใช้ intialCenter แทน center
              initialZoom: 14.0 //ใช้ initialZoom แทน Zoom
            ),
            children: [
              TileLayer(
                urlTemplate: getTileLayerUrl(), //เป็นฟังก์ชันที่คืนค่า URL ของ tiles
                subdomains: ['a','b'], // กำหนดโดเมนย่อยในเเผนที่
              ),
              MarkerLayer(
                  markers:[
                    Marker(
                      point: _currentLoation_load,
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      )
                    )
                  ]
              )
            ],
          )
        ],
      ),
    );
  }
  void _showAlertDialog(BuildContext context,String title,String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(message),
          actions: <Widget>[  // The name 'widget' isn't a type, so it can't be used as a type argument
            Row(children: [
              Spacer(), //ใช้ spaceer เพิ่อดันปุ่มชิดขวา
              ElevatedButton(
                onPressed: () => Navigator.pop(context,true),
                child: Text(
                  'ตกลง',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green
                  ),
                )
              )
            ],)
          ],
        );
      }
    );
  }
}
