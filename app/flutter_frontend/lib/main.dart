import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/buy_ticket_screen.dart';
import 'package:flutter_frontend/screens/create_event_screen.dart';
import 'package:flutter_frontend/screens/home_screen.dart';
import 'package:flutter_frontend/services/service_locator.dart';
import 'package:flutter_frontend/services/web3.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      'home': (context) => HomeScreen(),
      'buy-ticket': (context) => BuyTicketScreen(),
      'add-event': (context) => CreateEventScreen()
    },
    initialRoute: 'home',
  ));
}
