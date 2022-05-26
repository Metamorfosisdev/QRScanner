import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/directions_screen.dart';
import 'package:qr_scanner/screens/maps_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('HomeScreen'),
        actions: [
          Container(
            //  color: Colors.red,
            padding: const EdgeInsets.all(2),
            child: IconButton(
              splashRadius: 25,
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: const _HomePageBody(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions,
              color: Colors.blue,
            ),
            label: 'Directions',
          ),
        ],
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
