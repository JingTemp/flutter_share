import 'package:flutter/material.dart';
import 'package:xfvoice/xfvoice.dart';
class VoicePage extends StatefulWidget {

  

  @override
  _VoicePageState createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  String voiceMsg = '暂无数据';
  String iflyResultString = '按下方块说话';
  XFJsonResult xfResult;
  @override
  void initState() { 
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    final voice = XFVoice.shared;
    // 请替换成你的appid
    voice.init(appIdIos: '5d3e4fc2', appIdAndroid: '5d3e4fc2');
    final param = new XFVoiceParam();
    param.domain = 'iat';
    // param.asr_ptt = '0';   //取消注释可去掉标点符号
    param.asr_audio_path = 'audio.pcm';
    param.result_type = 'json'; //可以设置plain
    final map = param.toMap();
    map['dwa'] = 'wpgs';        //设置动态修正，开启动态修正要使用json类型的返回格式
    voice.setParameter(map);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('音频'),),
        body: Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Text(iflyResultString),
                  width: 300.0,
                  height: 300.0,
                  color: Colors.blueAccent,
                ),
                onTapDown: (d) {
                  setState(() {
                    voiceMsg = '按下';
                  });
                  _recongize();
                },
                onTapUp: (d) {
                  // _recongizeOver();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _recongize() {
    final listen = XFVoiceListener(
      onVolumeChanged: (volume) {
      },
      onBeginOfSpeech: () {
        xfResult = null;
      },
      onResults: (String result, isLast) {
        if (xfResult == null) {
          xfResult = XFJsonResult(result);
        } else {
          final another = XFJsonResult(result);
          xfResult.mix(another);
        }
        if (result.length > 0) {
          setState(() {
            iflyResultString = xfResult.resultText();
          });
        }
      },
      onCompleted: (Map<dynamic, dynamic> errInfo, String filePath) {
        setState(() {
          
        });
      }
    );
    XFVoice.shared.start(listener: listen);
  }

  void _recongizeOver() {
    XFVoice.shared.stop();
  }
}