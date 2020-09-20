import 'package:cargoshuttle/screens/customer_info_screen.dart';
import 'package:cargoshuttle/screens/home_screen.dart';
import 'package:cargoshuttle/screens/owner_info_screen1.dart';
import 'package:cargoshuttle/screens/owner_info_screen2.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_home_screen.dart';
import 'screens/customer_registration_screen.dart';
import 'screens/owner_registration_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(Cargoshuttle());
}

class Cargoshuttle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: OwnerInfoScreen1.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationHomeScreen.id: (context) => RegistrationHomeScreen(),
        CustomerRegistrationScreen.id: (context) =>
            CustomerRegistrationScreen(),
        CustomerInfoScreen.id: (context) => CustomerInfoScreen(),
        OwnerRegistrationScreen.id: (context) => OwnerRegistrationScreen(),
        OwnerInfoScreen1.id: (context) => OwnerInfoScreen1(),
        OwnerInfoScreen2.id: (context) => OwnerInfoScreen2(),
        HomeScreen.id: (context) => HomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
