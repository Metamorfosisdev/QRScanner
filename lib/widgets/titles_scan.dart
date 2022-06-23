import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_scanner/utils/utils.dart';

import '../providers/scan_list_provider.dart';

class ScanTitles extends StatelessWidget {
  final IconData icon;
  const ScanTitles({Key? key, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: scanListProvider.scans.length,
        itemBuilder: (_, i) => Dismissible(
              background: Container(
                color: Colors.red,
                child: const Text('Delete'),
              ),
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteScanById(scanListProvider.scans[i].id);
              },
              child: ListTile(
                title: Text(scanListProvider.scans[i].valor),
                subtitle: Text(scanListProvider.scans[i].id.toString()),
                leading: Icon(icon, color: Theme.of(context).primaryColor),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded,
                    color: Colors.grey),
                onTap: () => launchURL(scanListProvider.scans[i], context),
              ),
            ));
  }
}
