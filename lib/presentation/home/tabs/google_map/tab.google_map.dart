library google_map_tab;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as pl;
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

class GoogleMapsTab extends StatefulWidget {
  const GoogleMapsTab({super.key});

  @override
  State<GoogleMapsTab> createState() => _GoogleMapsTabState();
}

class _GoogleMapsTabState extends State<GoogleMapsTab>
    with AutomaticKeepAliveClientMixin {
  LatLng currentLocation = const LatLng(29.591768, 52.583698);
  bool isLoadingLocation = false;

  final Map<String, Marker> markers = {};

  late GoogleMapController mapController;

  late pl.PolylinePoints polylinePoints;

  List<LatLng> polylineCoordinates = [];

  Map<PolylineId, Polyline> polylines = {};

  Future<void> _createPolylines(
    final LatLng startPoint,
    final LatLng endPoint,
  ) async {
    polylinePoints = pl.PolylinePoints();

    final pl.PolylineResult result =
        await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCrThBeW0HO2zKkOfWDdQ2Vgq7uzdEUx04', // Google Maps API Key
      pl.PointLatLng(startPoint.latitude, startPoint.longitude),
      pl.PointLatLng(endPoint.latitude, endPoint.longitude),
      travelMode: pl.TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      for (final point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    const PolylineId id = PolylineId('route');

    final Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }

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
        calculateRoute: (final location) => _createPolylines(
          currentLocation,
          location,
        ),
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
          polylines: polylines.values.toSet(),
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
