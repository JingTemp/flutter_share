import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class DocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebviewScaffold(
        url: 'http://xuesheng.ouchn.cn/doc/',
        appBar: AppBar(title: Text('国开在线Javascript规范指南'),),
      ),
    );
  }
}