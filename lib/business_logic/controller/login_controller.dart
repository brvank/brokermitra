import 'package:brokers_mitra_frontend/business_logic/blocs/loading_bloc.dart';
import 'package:brokers_mitra_frontend/business_logic/blocs/message_bloc.dart';
import 'package:brokers_mitra_frontend/data/repositories/session_manager.dart';
import 'package:brokers_mitra_frontend/service/middleware/auth_interceptor.dart';
import 'package:brokers_mitra_frontend/service/network/api_service.dart';
import 'package:brokers_mitra_frontend/utils/constants/apis.dart';
import 'package:dio/dio.dart';

class LoginController {
  LoaderBloc loaderBloc = LoaderBloc();
  APIs apIs = APIs();
  MessageBloc messageBloc = MessageBloc("");

  late Dio dio;

  LoginController() {
    dio = Dio();
    dio.interceptors
        .add(AuthInterceptor(authToken: null, logoutCallback: () {}));
  }

  void login(String userName, String password, Function callback) {
    loaderBloc.add(LoaderLoading());
  }
}
