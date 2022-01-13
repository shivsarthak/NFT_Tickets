import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/drawer_item.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  navigate(String to) {}

  final List<Map> _drawerActions = [
    {
      'title': 'Home',
      'icon': Icon(Icons.home),
      'navigate': 'home',
    },
    {
      'title': 'Create Event',
      'icon': Icon(Icons.add),
      'navigate': 'add-event',
    },
    {
      'title': 'Buy Ticket',
      'icon': Icon(Icons.money),
      'navigate': 'buy-ticket',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Account Name"),
              accountEmail: Text("Account Email")),
          Column(
              children: _drawerActions
                  .map((e) => DrawerItem(
                      title: e['title'],
                      icon: e['icon'],
                      navigate: e['navigate']))
                  .toList()),
        ],
      ),
    );
  }
}
