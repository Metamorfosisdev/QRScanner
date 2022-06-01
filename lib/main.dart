import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/providers.dart';
import 'package:qr_scanner/screens/directions_screen.dart';
import 'package:qr_scanner/screens/home_screen.dart';
import 'package:qr_scanner/screens/map_screen.dart';
import 'package:qr_scanner/screens/maps_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UiProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: <String, Widget Function(BuildContext)>{
          '/home': (context) => const HomeScreen(),
          '/map': (context) => const MapScreen(),
          '/maps': (context) => const MapsScreen(),
          '/directions': (context) => const DirectionsScreen(),
        },
        theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue[900],
        )),
      ),
    );
  }
}
