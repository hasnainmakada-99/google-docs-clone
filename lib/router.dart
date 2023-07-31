import 'package:flutter/material.dart';
import 'package:google_docs_clone/screens/DocumentScreen.dart';
import 'package:google_docs_clone/screens/HomeScreen.dart';
import 'package:google_docs_clone/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(child: HomeScreen()),
    '/document/:id': (route) => MaterialPage(
          child: DocumentScreen(
            id: route.pathParameters['id'] ?? '',
          ),
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
