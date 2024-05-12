import 'dart:math';

import 'package:brokers_mitra_frontend/presentation/widgets/common.dart';
import 'package:brokers_mitra_frontend/utils/constants/colors.dart';
import 'package:brokers_mitra_frontend/utils/constants/ui_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brokers_mitra_frontend/business_logic/blocs/loading_bloc.dart';
import 'package:brokers_mitra_frontend/business_logic/blocs/message_bloc.dart';
import 'package:brokers_mitra_frontend/business_logic/controller/login_controller.dart';
import 'package:brokers_mitra_frontend/presentation/screens/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController _loginController;

  late TextEditingController _userNameController;
  late TextEditingController _passwordController;

  bool _loginButtonEnable = false;
  bool _loginState = true;

  @override
  void initState() {
    super.initState();

    _loginController = LoginController();

    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController.addListener(() {
      setButtonEnableCheck();
    });

    _passwordController.addListener(() {
      setButtonEnableCheck();
    });
  }

  void setButtonEnableCheck() {
    setState(() {
      if (_userNameController.value.text.isEmpty ||
          _passwordController.value.text.isEmpty) {
        _loginButtonEnable = false;
      } else {
        _loginButtonEnable = true;
      }
    });
  }

  void swapLoginSignUp() {
    setState(() {
      _loginState = !_loginState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(black),
          centerTitle: true,
          title: Text(
            UITextConstants.appName,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Color(white)),
          ),
        ),
        body: loginForm());
  }

  Widget loginForm() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoaderBloc>(
          create: (context) {
            return _loginController.loaderBloc;
          },
        ),
        BlocProvider<MessageBloc>(
          create: (context) {
            return _loginController.messageBloc;
          },
        )
      ],
      child: BlocConsumer<MessageBloc, String>(
        listener: (context, state) {
          if (state.isNotEmpty) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state),
                duration: const Duration(seconds: 2),
              ));
            }
          }
        },
        builder: (BuildContext context, state) {
          return BlocBuilder<LoaderBloc, bool>(
            builder: (context, loading) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 4, right: 4, top: 8, bottom: 8),
                      child: createTextInput(
                          textEditingController: _userNameController,
                          label: "User Name",
                          primary: const Color(grey50),
                          secondary: const Color(grey180),
                          enabled: !loading),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 4, right: 4, top: 8, bottom: 8),
                      child: createTextInput(
                          textEditingController: _passwordController,
                          label: "Password",
                          primary: const Color(grey50),
                          secondary: const Color(grey180),
                          enabled: !loading),
                    ),
                    MouseRegion(
                      cursor: _loginButtonEnable && !loading
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.forbidden,
                      child: GestureDetector(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          margin: const EdgeInsets.only(
                              left: 4, right: 4, top: 8, bottom: 8),
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, top: 12, bottom: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              color: (_loginButtonEnable && !loading)
                                  ? const Color(grey50)
                                  : Colors.grey,
                              border: Border.all(
                                  width: 2,
                                  color: (_loginButtonEnable && !loading)
                                      ? const Color(grey50)
                                      : const Color(grey180))),
                          child: Text(
                            loading
                                ? _loginState
                                    ? "Logging you in..."
                                    : "Signing you up..."
                                : _loginState
                                    ? "Login"
                                    : "Sign Up",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          if (_loginButtonEnable) {
                            if (_loginState) {
                              _loginController.login(
                                  _userNameController.value.text,
                                  _passwordController.value.text, () {
                                if (context.mounted) {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const HomeScreen();
                                  }), (_) => false);
                                }
                              });
                            } else {
                              _loginController.signup(
                                  _userNameController.value.text,
                                  _passwordController.value.text, () {
                                if (context.mounted) {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const HomeScreen();
                                  }), (_) => false);
                                }
                              });
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 4, right: 4, top: 8, bottom: 8),
                      child: TextButton(
                        onPressed: () {
                          swapLoginSignUp();
                        },
                        child: Text(
                          _loginState
                              ? "Didn't have an account? Sign up here."
                              : "Already have an account? Login here.",
                          style: const TextStyle(color: Color(pinkNeon)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
