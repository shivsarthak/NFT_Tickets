import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final String navigate;
  const DrawerItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.navigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(navigate);
      },
    );
  }
}
