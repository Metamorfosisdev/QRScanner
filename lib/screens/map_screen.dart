import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/models.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  MapType mapControl = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition initialPosition = CameraPosition(
      target: scan.getLatLng(),
      zoom: 14.4746,
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(
        markerId: const MarkerId('geo-location'),
        position: scan.getLatLng(),
      ),
    );
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        mapType: mapControl,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_pin),
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: scan.getLatLng(),
                zoom: 14.4746,
                tilt: 12,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      persistentFooterButtons: [
        TextButton(
          child: const Icon(Icons.maps_home_work_rounded),
          onPressed: () {
            if (mapControl == MapType.normal) {
              mapControl = MapType.hybrid;
            } else {
              mapControl = MapType.normal;
            }
            setState(() {});
          },
        ),
      ],
    );
  }
}
