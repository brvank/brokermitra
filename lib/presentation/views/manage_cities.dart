import 'package:brokers_mitra_frontend/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ManageCities extends StatefulWidget {
  const ManageCities({super.key});

  @override
  State<ManageCities> createState() => _ManageCitiesState();
}

class _ManageCitiesState extends State<ManageCities> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Your cities"),
          Wrap(
            children: getCities(),
          )
        ],
      ),
    );
  }

  List<Widget> getCities(){

    List<Widget> cities = [];
    List<String> cityData = ["Delhi", "Gurgaon", "Noida"];

    for(String city in cityData){
      cities.add(Container(
        decoration: BoxDecoration(
          color: Color(white),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(grey50))
        ),
        child: Text(city, style: TextStyle(color: Color(pinkNeon)),),
      ));
    }

    return cities;
  }
}
