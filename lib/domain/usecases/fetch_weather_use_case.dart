// lib/domain/use_cases/fetch_weather_use_case.dart

import 'package:weather/weather.dart';
import '../repositories/weather_repository_interface.dart';

class FetchWeatherUseCase {
  final WeatherRepositoryInterface repository;

  FetchWeatherUseCase(this.repository);

  Future<Weather> call() {
    return repository.fetchCurrentWeather();
  }
}
