import 'package:flutter/material.dart';
import 'package:deal/screens/splash_screen.dart';
import 'package:deal/screens/login_screen.dart';
import 'package:deal/screens/home_screen.dart';

class AppRoutes {
  static final routes = {
    '/splash': (context) => SplashScreen(),
    '/login': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(),
  };
}
