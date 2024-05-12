import 'dart:math';

import 'package:brokers_mitra_frontend/presentation/views/manage_cities.dart';
import 'package:brokers_mitra_frontend/presentation/views/properties_view.dart';
import 'package:brokers_mitra_frontend/presentation/views/uploader_view.dart';
import 'package:brokers_mitra_frontend/utils/constants/colors.dart';
import 'package:brokers_mitra_frontend/utils/constants/enum.dart';
import 'package:brokers_mitra_frontend/utils/constants/ui_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeScreenState homeScreenState = HomeScreenState.properties;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(black),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(white)),
        title: Text(
          UITextConstants.appName,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Color(white)),
        ),
      ),
      body: body(),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double width =
                    min(constraints.maxWidth, constraints.maxHeight) * 0.6;
                return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset(
                      "assets/images/logo.svg",
                      width: width,
                      height: width,
                    ));
              },
            ),
            ListTile(
              title: const Text("Properties"),
              onTap: () {
                updateView(HomeScreenState.properties);
              },
            ),
            ListTile(
              title: const Text("Uploader"),
              onTap: () {
                updateView(HomeScreenState.uploader);
              },
            ),
            ListTile(
              title: const Text("Manage Cities"),
              onTap: () {
                updateView(HomeScreenState.cityManager);
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateView(HomeScreenState screenState){
    Navigator.pop(context);
    setState(() {
      homeScreenState = screenState;
    });
  }

  Widget body(){
    return Stack(
      children: [
        getView(),
        // const Center(
        //   child: CircularProgressIndicator(
        //     color: Color(pinkNeon),
        //   ),
        // )
      ],
    );
  }

  Widget getView(){
    switch(homeScreenState){
      case HomeScreenState.properties:
        return LayoutBuilder(
          builder: (context, constraint){
            return Container(
              width: constraint.maxWidth,
              height: constraint.maxHeight,
              child: const PropertiesView()
            );
          },
        );
      case HomeScreenState.uploader:
        return LayoutBuilder(
          builder: (context, constraint){
            return Container(
                width: constraint.maxWidth,
                height: constraint.maxHeight,
                child: const UploaderView()
            );
          },
        );
      case HomeScreenState.cityManager:
        return LayoutBuilder(
          builder: (context, constraint){
            return Container(
                width: constraint.maxWidth,
                height: constraint.maxHeight,
                child: const ManageCities()
            );
          },
        );
    }
  }
}
