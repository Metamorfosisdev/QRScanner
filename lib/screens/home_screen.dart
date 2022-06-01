import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_scanner/providers/providers.dart';
import 'package:qr_scanner/screens/directions_screen.dart';
import 'package:qr_scanner/screens/maps_screen.dart';
import 'package:qr_scanner/widgets/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
      floatingActionButton: const _QrButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _QrButton extends StatelessWidget {
  const _QrButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.qr_code_scanner_rounded),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 'Cancel', false, ScanMode.QR);
        String barcodeScanRes = 'https://www.facebook.com/raul.espinal.754';
        print(barcodeScanRes);
      },
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpts;

    switch (currentIndex) {
      case 0:
        return MapsScreen();
      case 1:
        return DirectionsScreen();
      default:
        return Container(
          color: Colors.amber,
        );
    }
  }
}
