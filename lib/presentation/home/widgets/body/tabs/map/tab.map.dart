library map_tab;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../app.dart';
import '../../../../../../infrastructure/config/map.markers.dart';
import '../../../../../../infrastructure/config/theme/app.fonts.dart';
import '../../../../../../infrastructure/utils/app.sizes.dart';
import '../../../../../../infrastructure/utils/app.utils.dart';

part 'dialogs/dialog.add_marker.dart';
part 'dialogs/dialog.marker_info.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with AutomaticKeepAliveClientMixin {
  LatLng currentLocation = const LatLng(29.591768, 52.583698);
  bool isLoadingLocation = false;

  final Map<String, Marker> markers = {};

  late GoogleMapController mapController;

  Future<void> _retrieveUserLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }

    setState(() {
      isLoadingLocation = true;
    });
    final usersPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = LatLng(usersPosition.latitude, usersPosition.longitude);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation,
            zoom: 14,
          ),
        ),
      );
      isLoadingLocation = false;
    });
  }

  void _addMarker(final LatLng location, {final BitmapDescriptor? icon}) {
    final markerId = MarkerId('${location.latitude} ${location.longitude}');

    final marker = Marker(
      markerId: markerId,
      position: location,
      onTap: () => MarkerInfoDialog(
        id: markerId.value,
        location: location,
        calculateRoute: _calculateRoute,
        deleteMarker: _deleteMarker,
      ).show(context),
      icon: icon ?? BitmapDescriptor.defaultMarker,
    );

    setState(() {
      markers[markerId.value] = marker;
    });
  }

  void _deleteMarker(final String markerId) {
    setState(() {
      markers.remove(markerId);
    });
  }

  Future<void> _calculateRoute(final LatLng location) async {
    final request = DirectionsRequest(
      origin: currentLocation,
      destination: location,
    );

    debugPrint(request.toString());
  }

  @override
  void initState() {
    super.initState();
    DirectionsService.init('AIzaSyCrThBeW0HO2zKkOfWDdQ2Vgq7uzdEUx04');
    _retrieveUserLocation();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    super.build(context);

    final themeData = Theme.of(context);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentLocation,
            zoom: 10,
          ),
          onMapCreated: (final controller) {
            mapController = controller;
          },
          markers: markers.values.toSet(),
          scrollGesturesEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          mapToolbarEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: true,
          onLongPress: (final location) => AddMarkerDialog(
            location: location,
            addMarker: _addMarker,
          ).show(context),
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
        ),
        if (isLoadingLocation)
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.points_16,
                vertical: AppSizes.points_12,
              ),
              decoration: BoxDecoration(
                color: themeData.colorScheme.background.withOpacity(0.8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  AppUtils.verticalSpacer(),
                  const Text('Retrieving your location'),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => false;
}
