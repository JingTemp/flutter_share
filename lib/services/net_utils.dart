import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_share/config/service_url.dart';
Map<String,dynamic> optHeader = {
  'accept-language':'zh-cn',
  'content-type':'application/json'
};

var dio = new Dio(BaseOptions(connectTimeout: 30000,headers: optHeader));

class NetUtils {
  static Future get(String url, [Map<String, dynamic> params]) async {
    var response;
    if(params != null) {
      response = await dio.get(ServicePath[url], queryParameters: params);
    } else {
      response = await dio.get(ServicePath[url]);
    }
    return response.data;
  }
  static Future post(String url, Map<String, dynamic> params) async {
    var response = await dio.post(ServicePath[url], data: params);
    return response.data;
  }
}