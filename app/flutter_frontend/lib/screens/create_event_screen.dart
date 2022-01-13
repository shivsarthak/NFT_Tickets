import 'package:flutter/material.dart';
import 'package:flutter_frontend/services/service_locator.dart';
import 'package:flutter_frontend/services/web3.dart';
import 'package:flutter_frontend/widgets/custom_app_bar.dart';
import 'package:flutter_frontend/widgets/drawer.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  String? name, uri;
  BigInt? num;
  Future create() async {
    final instance = locator<Web3>();
    await instance.createEvent("shivsarthak.com", 'MINT', 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Event URI"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Event Name"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "No. of tickets available"),
            ),
            SizedBox(height: 12),
            ElevatedButton(
                onPressed: () {
                  create().then((val) {
                    Navigator.of(context).pushReplacementNamed('home');
                  });
                },
                child: Text("Create Event"))
          ],
        ),
      ),
    );
  }
}
