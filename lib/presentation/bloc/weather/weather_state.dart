part of 'weather_bloc.dart';

@immutable
sealed class MianPageState {}

final class MianPageInitial extends MianPageState {}

abstract class MainPageActionState extends MianPageState {}

final class MainPageInitial extends MianPageState {}

class MainPageSuccessfullState extends MianPageState {
  final Weather weather;

  MainPageSuccessfullState(this.weather);
}

class MainPageLoadingState extends MianPageState {}

class MainPageErrorState extends MianPageState {}
