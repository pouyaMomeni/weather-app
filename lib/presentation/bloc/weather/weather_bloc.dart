import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';
import 'package:weatherr/domain/usecases/fetch_weather_use_case.dart';

part 'weather-event.dart';
part 'weather_state.dart';

class MianPageBloc extends Bloc<MianPageEvent, MianPageState> {
  final FetchWeatherUseCase fetchWeatherUseCase;
  MianPageBloc(this.fetchWeatherUseCase) : super(MianPageInitial()) {
    on<MainPageInitialFetchEvent>(mainPageInitialFetchEvent);
  }

  FutureOr<void> mainPageInitialFetchEvent(
      MainPageInitialFetchEvent event, Emitter<MianPageState> emit) async {
    emit(MainPageLoadingState());
    try {
      final weather =
          await fetchWeatherUseCase(); // Correct: calling `fetchWeatherUseCase` as a function
      emit(MainPageSuccessfullState(
          weather)); // `weather` is now of type `Weather`
    } catch (e) {
      print(e.toString());
    }
  }
}
