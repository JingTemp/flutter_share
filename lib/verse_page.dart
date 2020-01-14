import 'package:flutter/material.dart';
import 'package:flutter_share/services/net_utils.dart';
class VersePage extends StatefulWidget {
  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
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