import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:hues_dovui/src/config/app_endpoint.dart';

class DioService extends DioForNative {
  DioService({String baseUrl = AppEndpoint.BASE_URL, BaseOptions options})
      : super(options) {
    this.interceptors.add(
          InterceptorsWrapper(
            onRequest: _request,
            onResponse: _response,
            onError: _error,
          ),
        );
    this.options.baseUrl = baseUrl;
  }

  _request(RequestOptions options) {
    options.connectTimeout = AppEndpoint.connectionTimeout;
    options.receiveTimeout = AppEndpoint.receiveTimeout;
    return options;
  }

  _response(Response response) {
    return response;
  }

  _error(DioError error) {
    return error;
  }
}
