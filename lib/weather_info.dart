import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'Models/WeatherModel.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({super.key});

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {

  Future<WeatherModel> getProducts() async {
    var data;
    final response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=bahawalpur,pk&APPID=dc299ec55400909e246153b010389c9d"),);
     data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {

      return WeatherModel.fromJson(data);

    } else {
      return WeatherModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3C80E3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getProducts(),
                  builder: (context, snapshot) {


                    if (!snapshot.hasData) {
                      return const Center(
                        child:SpinKitFadingCircle(
                          color: Colors.white,
                        )
                      );
                    } else {
                      double temp = snapshot.data!.main!.temp!.toDouble();
                      double celsiusTemp = temp - 273.15;
                      String totalTemp = celsiusTemp.toStringAsFixed(2);

                      double max = snapshot.data!.main!.tempMax!.toDouble();
                      double temp_max = temp - 273.15;
                      String maxT = temp_max.toStringAsFixed(2);

                      double min = snapshot.data!.main!.tempMin!.toDouble();
                      double temp_min = temp - 273.15;
                      String minT = temp_min.toStringAsFixed(2);

                      double metersPerSecond =
                      snapshot.data!.wind!.speed!.toDouble();
                      double kilometersPerHour = metersPerSecond * 3.6;
                      String formattedSpeed =
                      kilometersPerHour.toStringAsFixed(2);
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text:"${snapshot.data!.name.toString()} ",
                                    style: GoogleFonts.radioCanada(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            color: Colors.white))),
                                TextSpan(children: [
                                  TextSpan(
                                      text: snapshot.data!.sys!.country
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white))
                                ])
                              ])),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 40,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: totalTemp,
                                      style: GoogleFonts.radioCanada(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 60,
                                              color: Colors.white))),
                                  TextSpan(children: [
                                    const TextSpan(
                                        text: "  Speed ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white)),
                                    TextSpan(
                                        text: formattedSpeed,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white)),
                                    const TextSpan(
                                        text: " Km/hr",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white)),
                                  ])
                                ])),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 290,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/cloud1.png"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 30),
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              child: Card(
                                color: const Color(0xff74A0DF),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Max Temp",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          Text(maxT,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Min Temp",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          Text(minT,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Pressure",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          Text(
                                              snapshot.data!.main!.pressure
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
