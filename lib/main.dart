import 'dart:math';

import 'package:brokers_mitra_frontend/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brokers_mitra_frontend/data/repositories/session_manager.dart';
import 'package:brokers_mitra_frontend/presentation/screens/home_screen.dart';
import 'package:brokers_mitra_frontend/presentation/screens/login_screen.dart';
import 'package:brokers_mitra_frontend/utils/configurations/route_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: "Brokers' Mitra",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(black)),
        fontFamily: GoogleFonts.montserrat().fontFamily),
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SessionManager sessionManager = SessionManager();
  bool loggedIn = false;
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();

    checkForUserSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints){
            double width = min(constraints.maxWidth, constraints.maxHeight) * 0.6;
            return SvgPicture.asset("assets/images/logo.svg", width: width, height: width,);
          },
        ),
      ),
    );
  }

  void checkForUserSession() async {
    sharedPreferences = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 1), () {
      loggedIn =
          sessionManager.getToken(sharedPreferences!).isEmpty ? false : true;

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        if (loggedIn || true) {
          return const LoginScreen();
        } else {
          return const LoginScreen();
        }
      }), (_) => false);
    });
  }
}
