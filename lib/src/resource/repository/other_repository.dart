import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hues_dovui/src/config/app_endpoint.dart';
import 'package:hues_dovui/src/resource/model/app.dart';
import 'package:hues_dovui/src/resource/service/DioService.dart';

class OtherRepository {
  Future<List<App>> getMoreApps() async {
    final _apps = <App>[];
    Map<String, dynamic> params = {
      "os": Platform.isAndroid ? "android" : "ios"
    };
    try {
      final _response = await DioService().get(
          AppEndpoint.BASE_URL + AppEndpoint.MORE_APPS, queryParameters: params);
      List.from(jsonDecode(_response.data)['apps']).forEach((element) {
        _apps.add(App.fromJson(element));
      });
    } on DioError catch (e) {
      print(e.error);
    }
    return _apps;
  }
}
