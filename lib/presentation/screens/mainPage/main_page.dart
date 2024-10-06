import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherr/constants/color.dart';
import 'package:weatherr/data/repositories/weather_repository.dart';
import 'package:weatherr/domain/usecases/fetch_weather_use_case.dart';
import 'package:weatherr/presentation/bloc/weather/weather_bloc.dart';
import 'package:weatherr/presentation/widgets/filter.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late double _deviceWidth;

  late double _deviceHeight;

  late final MianPageBloc mianPageBloc;

  @override
  void initState() {
    super.initState();

    final WeatherRepository weatherRepository = WeatherRepository();
    final FetchWeatherUseCase fetchWeatherUseCase =
        FetchWeatherUseCase(weatherRepository);
    mianPageBloc = MianPageBloc(fetchWeatherUseCase);
    mianPageBloc.add(MainPageInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: BlocConsumer<MianPageBloc, MianPageState>(
        bloc: mianPageBloc,
        listenWhen: (previous, current) => current is MainPageActionState,
        buildWhen: (previous, current) => current is! MainPageActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case MainPageLoadingState:
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.white,
                ),
              );
            case MainPageSuccessfullState:
              final data = state as MainPageSuccessfullState;
              return Padding(
                padding:
                    const EdgeInsets.fromLTRB(40, kToolbarHeight * 1.2, 40, 20),
                child: SizedBox(
                  height: _deviceHeight,
                  child: Stack(
                    children: [
                      const FilterWidget(),
                      SizedBox(
                        width: _deviceWidth,
                        height: _deviceHeight,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: AppColor.white,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: _deviceWidth * 0.01,
                                  ),
                                  Text(
                                    '${data.weather.country} - ${data.weather.areaName}',
                                    style: const TextStyle(
                                        color: AppColor.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _deviceHeight * 0.005,
                            ),
                            _getWeatherIcon(data.weather.weatherConditionCode!),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${data.weather.temperature!.celsius!.round()}°C',
                                style: const TextStyle(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                data.weather.weatherMain!,
                                style: const TextStyle(
                                  color: AppColor.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _deviceHeight * 0.005,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                DateFormat('EEEE dd .')
                                    .add_jm()
                                    .format(data.weather.date!),
                                style: const TextStyle(
                                  color: AppColor.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _deviceHeight * 0.08,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: _deviceWidth * 0.15,
                                      height: _deviceHeight * 0.07,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/11.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                            color: AppColor.thirdColor,
                                          ),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(data.weather.sunrise!),
                                          style: const TextStyle(
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: _deviceWidth * 0.15,
                                      height: _deviceHeight * 0.07,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/12.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(
                                              color: AppColor.fourthColor),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(data.weather.sunset!),
                                          style: const TextStyle(
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: _deviceWidth * 0.15,
                                      height: _deviceHeight * 0.07,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/13.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Temp Max',
                                          style: TextStyle(
                                            color: AppColor.thirdColor,
                                          ),
                                        ),
                                        Text(
                                          '${data.weather.tempMax!.celsius!.round()}°C',
                                          style: const TextStyle(
                                            color: AppColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: _deviceWidth * 0.15,
                                      height: _deviceHeight * 0.07,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/14.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Temp Min',
                                          style: TextStyle(
                                            color: AppColor.fourthColor,
                                          ),
                                        ),
                                        Text(
                                          '${data.weather.tempMin!.celsius!.round()}°C',
                                          style: const TextStyle(
                                            color: AppColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );

            default:
              return Center(child: Text('ssssssssssssss'));
          }
        },
      ),
    );
  }

  Widget _getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/images/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/images/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/images/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/images/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/images/5.png');
      case == 800:
        return Image.asset('assets/images/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/images/7.png');
      default:
        return Image.asset('assets/images/7.png');
    }
  }
}
