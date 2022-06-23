import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';

void launchURL(ScanModel scan, BuildContext context) async {
  if (scan.valor.contains('http')) {
    if (!await launchUrl(Uri.parse(scan.valor))) throw 'Could not launch $scan';
  } else {
    Navigator.pushNamed(context, '/map', arguments: scan);
  }
}

// 
