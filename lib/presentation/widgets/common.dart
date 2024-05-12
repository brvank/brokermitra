import 'dart:ui';

import 'package:brokers_mitra_frontend/utils/constants/colors.dart';
import 'package:brokers_mitra_frontend/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget createTextInput(
    {required TextEditingController textEditingController,
    required String label,
    required Color primary,
    required Color secondary,
    bool enabled = true,
    Color backgroundColor = Colors.white}) {
  return TextField(
      autofocus: true,
      cursorColor: primary,
      controller: textEditingController,
      style: TextStyle(color: enabled ? primary : secondary),
      decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: primary)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: secondary)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: secondary)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: primary))),
      enabled: enabled);
}

Widget createSubscriptionCard(
    {required int price,
    required SubscriptionType subscriptionType,
    required SubscriptionType selectedType,
    required String info}) {
  List<Widget> children = [];

  if (subscriptionType == selectedType) {
    children.add(Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: const Color(greenNeon),
      child: const Center(
        child: Text(
          "Selected",
          style: TextStyle(color: Color(white)),
        ),
      ),
    ));
  }

  children.add(
    Container(
      color: const Color(black),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$ $price", style: const TextStyle(color: Color(white), fontWeight: FontWeight.bold),),
              Radio(value: subscriptionType, groupValue: selectedType, onChanged: (_){}, activeColor: const Color(greenNeon),)
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 16),
            child: Text(info, style: TextStyle(color: Color(blueNeon))),
          )
        ],
      ),
    )
  );

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: children,
    ),
  );
}
