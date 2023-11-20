part of map_tab;

class MarkerInfoDialog extends StatefulWidget {
  const MarkerInfoDialog({
    required this.id,
    required this.location,
    required this.calculateRoute,
    required this.deleteMarker,
    super.key,
  });

  final String id;
  final LatLng location;
  final void Function(LatLng location) calculateRoute;
  final void Function(String markerId) deleteMarker;

  void show(
    final BuildContext context,
  ) =>
      showDialog(
        context: context,
        builder: (final context) => this,
      );

  @override
  State<MarkerInfoDialog> createState() => _MarkerInfoDialogState();
}

class _MarkerInfoDialogState extends State<MarkerInfoDialog> {
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

  @override
  void initState() {
    super.initState();
    _retrievePlaceMark();
  }

  Widget _buildLocationInfo({
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
              'lat: ${widget.location.latitude}\nlong:${widget.location.longitude}',
            ),
            AppUtils.verticalSpacer(AppSizes.points_4),
            Text(
              'Address: ${isLoadingPlaceMark ? 'Loading...' : placeMarks.firstOrNull ?? 'N/A'}',
            ),
          ],
        ),
      );

  Widget _buildButtons({
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
            widget.deleteMarker(widget.id);
            dismiss();
          },
          child: Text(
            'Delete',
            style: themeData.textTheme.labelLarge
                ?.copyWith(color: themeData.colorScheme.error.withOpacity(0.8)),
          ),
        ),
      ],
    );
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
              themeData: themeData,
            ),
            AppUtils.verticalSpacer(),
            ElevatedButton(
                onPressed: () => widget.calculateRoute(widget.location),
                child: Text(
                  'Get Route',
                  style: themeData.textTheme.labelLarge
                      ?.copyWith(color: themeData.colorScheme.onPrimary),
                )),
            AppUtils.verticalSpacer(),
            _buildButtons(
              themeData: themeData,
            ),
          ],
        ),
      ),
    );
  }
}
