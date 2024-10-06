// lib/data/repositories/weather_repository.dart

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import '../../domain/repositories/weather_repository_interface.dart';

class WeatherRepository implements WeatherRepositoryInterface {
  final WeatherFactory weatherFactory;

  WeatherRepository()
      : weatherFactory = WeatherFactory('f546611b582d42836829ec285128b1e6',
            language: Language.ENGLISH);

  @override
  Future<Weather> fetchCurrentWeather() async {
    Position position = await _determinePosition();
    return await weatherFactory.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
