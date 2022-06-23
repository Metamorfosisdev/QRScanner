import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_scanner/providers/providers.dart';
import 'package:qr_scanner/screens/directions_screen.dart';
import 'package:qr_scanner/screens/maps_screen.dart';
import 'package:qr_scanner/utils/utils.dart';
import 'package:qr_scanner/widgets/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Records'),
        actions: [
          Container(
            //  color: Colors.red,
            padding: const EdgeInsets.all(2),
            child: IconButton(
              splashRadius: 25,
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () {
                final scanListProvider =
                    Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.deleteWhole();
              },
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
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);
        // String barcodeScanRes = 'https://www.facebook.com/raul.espinal.754';
        // String barcodeScanRes = 'geo:20.687133,-103.345289';
        if (barcodeScanRes == '-1') {
          return;
        }
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.newScan(barcodeScanRes);
        launchURL(newScan, context);
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

    final tempScan = ScanModel(valor: 'http://google.com');

    /*
     * Call instance of ScanListProvider to select the type
     */
    final ScanListProvider scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.width,
    //   child: AnimatedCrossFade(
    //       firstChild: MapsScreen(),
    //       secondChild: DirectionsScreen(),
    //       crossFadeState: currentIndex == 1
    //           ? CrossFadeState.showFirst
    //           : CrossFadeState.showSecond,
    //       duration: Duration(milliseconds: 500)),
    // );
    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsScreen();
      case 1:
        scanListProvider.loadScansByType('http');
        return const DirectionsScreen();
      default:
        return const MapsScreen();
    }
  }
}
