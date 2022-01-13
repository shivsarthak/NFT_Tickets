import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/event.dart';
import 'package:flutter_frontend/services/service_locator.dart';
import 'package:flutter_frontend/services/web3.dart';
import 'package:flutter_frontend/widgets/custom_app_bar.dart';
import 'package:flutter_frontend/widgets/drawer.dart';
import 'package:flutter_frontend/widgets/event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _events = [];

  fetch() async {
    final instance = locator<Web3>();
    var res = await instance.query('getOwnedEvents');

    setState(() {
      _events = res;
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Text(
              "Your Owned Events",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Wrap(
            children: [
              ..._events.map((e) => EventCard()),
            ],
          )
        ],
      ),
    );
  }
}
