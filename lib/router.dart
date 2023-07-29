import 'package:flutter/material.dart';
import 'package:google_docs_clone/screens/HomeScreen.dart';
import 'package:google_docs_clone/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: HomeScreen(),
        ),
  },
);

final loggedOutRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: LoginScreen(),
        ),
  },
);
