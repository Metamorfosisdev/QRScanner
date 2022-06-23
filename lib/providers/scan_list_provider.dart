import 'package:flutter/cupertino.dart';
import 'package:qr_scanner/models/models.dart';
import 'package:qr_scanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String SelectedType = 'http';

  Future<ScanModel> newScan(String value) async {
    final ScanModel newScan = ScanModel(valor: value);
    final id = await DbProvider.db.newScan(newScan);
    newScan.id = id;

    if (SelectedType == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final scans = await DbProvider.db.getWholeScans();
    this.scans = [...?scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DbProvider.db.getScansByType(type);
    this.scans = [...?scans];
    SelectedType = type;
    notifyListeners();
  }

  deleteWhole() async {
    await DbProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int? id) async {
    await DbProvider.db.deleteScan(id);
  }
}
