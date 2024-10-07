// lib/service_locator.dart

import 'package:get_it/get_it.dart';
import 'package:weatherr/data/repositories/weather_repository.dart';
import 'package:weatherr/domain/usecases/fetch_weather_use_case.dart';
import 'package:weatherr/presentation/bloc/weather/weather_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<WeatherRepository>(WeatherRepository());

  getIt.registerFactory(() => FetchWeatherUseCase(getIt<WeatherRepository>()));

  getIt.registerFactory(() => MianPageBloc(getIt<FetchWeatherUseCase>()));
}
