import 'package:brokers_mitra_frontend/data/model/property.dart';
import 'package:brokers_mitra_frontend/presentation/widgets/common.dart';
import 'package:brokers_mitra_frontend/utils/constants/colors.dart';
import 'package:brokers_mitra_frontend/utils/constants/enum.dart';
import 'package:flutter/material.dart';

class PropertiesView extends StatefulWidget {
  const PropertiesView({super.key});

  @override
  State<PropertiesView> createState() => _PropertiesViewState();
}

class _PropertiesViewState extends State<PropertiesView> {
  SubscriptionType selectedType = SubscriptionType.monthly;

  updateSubscriptionType(SubscriptionType type) {
    setState(() {
      selectedType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [paymentSubscriptionCards(), paymentButton(), allProperties()],
    );
  }

  Widget paymentSubscriptionCards() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          createPropertyElement(
              400,
              "Get all the latest properties details for a month.",
              SubscriptionType.monthly,
              selectedType),
          createPropertyElement(
              1000,
              "Get all the latest properties details for a quarter.",
              SubscriptionType.quarterly,
              selectedType),
          createPropertyElement(
              1800,
              "Get all the latest properties details for a half year.",
              SubscriptionType.halfYearly,
              selectedType),
          createPropertyElement(
              3000,
              "Get all the latest properties details for a year.",
              SubscriptionType.yearly,
              selectedType),
        ],
      ),
    );
  }

  Widget createPropertyElement(int price, String info, SubscriptionType type,
      SubscriptionType selected) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          updateSubscriptionType(type);
        },
        child: createSubscriptionCard(
            price: price,
            subscriptionType: type,
            selectedType: selected,
            info: info),
      ),
    );
  }

  Widget paymentButton() {
    return ElevatedButton(onPressed: () {}, child: Text("Pay Now"));
  }

  Widget allProperties() {
    List<Property> properties = [];

    properties.add(Property(title: "2BHK full furnished flat", price: 20000));
    properties.add(Property(title: "1BHK full furnished flat", price: 15000));
    properties.add(Property(title: "2BHK semi furnished flat", price: 15000));
    properties.add(Property(title: "1BHK semi furnished flat", price: 10000));
    properties.add(Property(title: "2BHK no furnished flat", price: 10000));
    properties.add(Property(title: "1BHK no furnished flat", price: 70000));
    properties.add(Property(title: "1BHK full furnished flat", price: 15000));
    properties.add(Property(title: "2BHK semi furnished flat", price: 15000));
    properties.add(Property(title: "1BHK semi furnished flat", price: 10000));
    properties.add(Property(title: "2BHK no furnished flat", price: 10000));
    properties.add(Property(title: "1BHK no furnished flat", price: 70000));
    properties.add(Property(title: "1BHK full furnished flat", price: 15000));
    properties.add(Property(title: "2BHK semi furnished flat", price: 15000));
    properties.add(Property(title: "1BHK semi furnished flat", price: 10000));
    properties.add(Property(title: "2BHK no furnished flat", price: 10000));
    properties.add(Property(title: "1BHK no furnished flat", price: 70000));

    List<Widget> widgets = [];

    for(Property property in properties){
      widgets.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Color(white),
            border: Border.all(color: Color(blueNeon), width: 4),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(property.title),
              Text("\$" + property.price.toString())
            ],
          ),
        )
      );
    }

    

    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: widgets,
      ),
    );
  }
}
