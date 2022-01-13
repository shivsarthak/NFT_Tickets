import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/custom_app_bar.dart';
import 'package:flutter_frontend/widgets/drawer.dart';

class BuyTicketScreen extends StatefulWidget {
  const BuyTicketScreen({Key? key}) : super(key: key);

  @override
  _BuyTicketScreenState createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(),
    );
  }
}
