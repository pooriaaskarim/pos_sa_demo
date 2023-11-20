import 'dart:core';

class AppApis {
  AppApis._();

  // BaseURL
  static const String _apiBaseUrl = 'https://dog.ceo/api';

  // Breeds
  static const String _breedsBase = '$_apiBaseUrl/breeds';
  // Breed
  static const String _breedBase = '$_apiBaseUrl/breed';

  /// List All Breeds
  static String getAllBreeds() => '$_breedsBase/list/all';

  /// Fetch Random Image form All Breeds
  static String getRandomImages({final int count = 1}) {
    assert(count >= 1 && count <= 50, 'Can return up to 50 images max');

    return '$_breedsBase/image/random${(count > 1) ? '/$count' : ''}';
  }

  /// Fetch All Images by Breed
  static String getAllImagesByBreed(final String breed) =>
      '$_breedBase/$breed/images';

  /// Fetch Random Image(s) by breed
  static String getRandomImagesByBreed(
    final String breed, {
    final int count = 1,
  }) {
    assert(count >= 1 && count <= 50, 'Can return up to 50 images max');

    return '$_breedBase/$breed/images/random/$count';
  }

  /// Fetch All Images by Sub-Breed
  static String getAllImagesBySubBreed(
    final String breed,
    final String subBreed,
  ) =>
      '$_breedBase/$breed/$subBreed/images';

  /// Fetch All Sub-Breeds
  static String getAllSubBreeds(
    final String breed,
    final String subBreed,
  ) =>
      '$_breedBase/$breed/$subBreed/list';

  /// Fetch Random Image(s) by breed
  static String getRandomImagesBySubBreed(
    final String breed,
    final String subBreed, {
    final int count = 1,
  }) {
    assert(count >= 1 && count <= 50, 'Can return up to 50 images max');

    return '$_breedBase/$breed/$subBreed/images/random/$count';
  }
}
