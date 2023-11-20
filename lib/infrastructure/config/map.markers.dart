import '../utils/app.utils.dart';

enum MapMarker { kitty, sunmoon, skull, unicorn }

extension MapMarkerExtension on MapMarker {
  String get asset => '${AppUtils.imageAssetsPath}$name.png';
}
