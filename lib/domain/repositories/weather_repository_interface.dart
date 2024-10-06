// lib/domain/repositories/weather_repository_interface.dart

import 'package:weather/weather.dart';

abstract class WeatherRepositoryInterface {
  Future<Weather> fetchCurrentWeather();
}
