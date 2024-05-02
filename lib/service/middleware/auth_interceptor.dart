import 'package:dio/dio.dart';

class AuthInterceptor implements Interceptor {
  final String? authToken;
  final Function logoutCallback;

  AuthInterceptor({required this.authToken, required this.logoutCallback});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {}

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(authToken != null) {
      options.headers['Authorization'] = authToken;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode == 401){
      logoutCallback();
    }
  }
}
