import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/services/net_utils.dart';
class VersePage extends StatefulWidget {
  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get battery level: ${e.message} .';
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  var _verse;
  @override
  void initState() {
    _verse = _getVerse();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('诗句欣赏'),),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(75, 92, 196, 1),
          ),
          child: FutureBuilder(
            future: _verse,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                var data = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(data['content'], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20,),
                    Text(
                      "${data['origin']} —— ${data['author']}", 
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.right,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 250),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Get Battery Level'),
                            onPressed: _getBatteryLevel,
                          ),
                          Text(_batteryLevel, style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('少待须臾...', style: TextStyle(color: Colors.white),),
                );
              }
            },
          ),
        ),
        
      ),
    );
  }
  Future _getVerse() async {
    var response = NetUtils.get('verse');
    return response;
  }
}