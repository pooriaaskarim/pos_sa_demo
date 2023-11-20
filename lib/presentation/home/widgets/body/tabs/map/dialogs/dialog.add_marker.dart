part of map_tab;

class AddMarkerDialog extends StatefulWidget {
  const AddMarkerDialog({
    required this.location,
    required this.addMarker,
    super.key,
  });

  void show(
    final BuildContext context,
  ) =>
      showDialog(
        context: context,
        builder: (final context) => this,
      );

  final LatLng location;
  final void Function(LatLng location, {BitmapDescriptor? icon}) addMarker;

  @override
  State<AddMarkerDialog> createState() => _AddMarkerDialogState();
}

class _AddMarkerDialogState extends State<AddMarkerDialog> {
  MapMarker? customMarker;
  List<Placemark> placeMarks = [];
  bool isLoadingPlaceMark = false;

  Future<void> _retrievePlaceMark() async {
    setState(() {
      isLoadingPlaceMark = true;
    });
    try {
      placeMarks = await placemarkFromCoordinates(
        widget.location.latitude,
        widget.location.longitude,
      );
    } on Exception {
      rethrow;
    } finally {
      setState(() {
        isLoadingPlaceMark = false;
      });
    }
  }

  Widget _buildLocationInfo(
    final LatLng location, {
    required final ThemeData themeData,
  }) =>
      Container(
        padding: const EdgeInsets.all(AppSizes.points_8),
        decoration: BoxDecoration(
          color: themeData.colorScheme.outline.withOpacity(.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppUtils.borderRadius),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('Location Info:'),
            AppUtils.verticalSpacer(AppSizes.points_8),
            Text(
              'lat: ${location.latitude}\nlong:${location.longitude}',
            ),
            AppUtils.verticalSpacer(AppSizes.points_4),
            Text(
              'Address: ${isLoadingPlaceMark ? 'Loading...' : placeMarks.firstOrNull ?? 'N/A'}',
            ),
          ],
        ),
      );

  Widget _buildButtons(
    final LatLng location, {
    required final ThemeData themeData,
  }) {
    void dismiss() {
      App.navigator?.pop();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: dismiss,
          child: Text(
            'Dismiss',
            style: themeData.textTheme.labelLarge
                ?.copyWith(fontWeight: AppFonts.light),
          ),
        ),
        TextButton(
          onPressed: () async {
            widget.addMarker(
              location,
              icon: customMarker == null
                  ? null
                  : await BitmapDescriptor.fromAssetImage(
                      const ImageConfiguration(
                        size: Size.fromRadius(AppSizes.points_24),
                      ),
                      customMarker!.asset,
                    ),
            );
            dismiss();
          },
          child: Text(
            'Add Location',
            style: themeData.textTheme.labelLarge
                ?.copyWith(color: themeData.colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildMarkersList(final ThemeData themeData) => SizedBox(
        height: AppSizes.points_64 * 1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select Marker:'),
            AppUtils.verticalSpacer(AppSizes.points_4),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: MapMarker.values.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(AppSizes.points_4),
                  itemBuilder: (final context, final index) {
                    final marker = MapMarker.values[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.points_4,
                      ),
                      child: Material(
                        borderRadius:
                            BorderRadius.circular(AppUtils.borderRadius),
                        color: customMarker == marker
                            ? themeData.colorScheme.secondary.withOpacity(0.3)
                            : Colors.transparent,
                        type: MaterialType.button,
                        child: InkWell(
                          onTap: () => setState(() {
                            customMarker =
                                customMarker == marker ? null : marker;
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.points_4),
                            child: Image.asset(marker.asset),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    _retrievePlaceMark();
  }

  @override
  Widget build(final BuildContext context) {
    final themeData = Theme.of(context);
    return Dialog(
      backgroundColor: themeData.colorScheme.background.withOpacity(0.9),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.points_12,
          horizontal: AppSizes.points_16,
        ),
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLocationInfo(
              widget.location,
              themeData: themeData,
            ),
            AppUtils.verticalSpacer(),
            _buildMarkersList(themeData),
            AppUtils.verticalSpacer(),
            _buildButtons(
              widget.location,
              themeData: themeData,
            ),
          ],
        ),
      ),
    );
  }
}
