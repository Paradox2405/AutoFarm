import 'package:autofarm/helpers/enums.dart';
import 'package:autofarm/modals/sensor_data_modal.dart';
import 'package:autofarm/widgets/app_bar.dart';
import 'package:autofarm/widgets/elevated_button.dart';
import 'package:autofarm/widgets/percent_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../../helpers/app_colors.dart';
import '../sensor_data/sensor_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DatabaseReference waterPumpRef =
      FirebaseDatabase.instance.ref('waterPumpValue');

  DatabaseReference predictionRef =
  FirebaseDatabase.instance.ref('predictionValue');
  double moistureSensorValue = 0.0;
  double humiditySensorValue = 0.0;
  double lightSensorValue = 0.0;
  double temperatureSensorValue = 0.0;
  bool waterPumpActive = false;
  double predictionValue=0.0;

  @override
  void initState() {
    super.initState();
    _fetchPredictionData();
    _fetchWaterPumpData();
    _fetchMoistureSensorData();
    _fetchHumiditySensorData();
    _fetchLightSensorData();
    _fetchTemperatureSensorData();
  }

  void _fetchMoistureSensorData() async {
    DatabaseReference moistureSensorRef =
        FirebaseDatabase.instance.ref('moistureSensor/moistureSensorValue');
    moistureSensorRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(data as Map);
      moistureSensorValue = dataMap.entries.last.value;
      setState(() {});
    });
  }

  void _fetchHumiditySensorData() async {
    DatabaseReference humiditySensorRef =
        FirebaseDatabase.instance.ref('humiditySensor/humiditySensorValue');
    humiditySensorRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(data as Map);
      humiditySensorValue = dataMap.entries.last.value;
      setState(() {});
    });
  }

  void _fetchLightSensorData() async {
    DatabaseReference lightSensorRef =
        FirebaseDatabase.instance.ref('lightSensor/lightSensorValue');
    lightSensorRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(data as Map);
      lightSensorValue = dataMap.entries.first.value;
      setState(() {});
    });
  }

  void _fetchTemperatureSensorData() async {
    DatabaseReference tempSensorRef =
        FirebaseDatabase.instance.ref('tempSensor/tempSensorValue');
    tempSensorRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(data as Map);
      temperatureSensorValue = dataMap.entries.first.value;
      setState(() {});
    });
  }

  void _fetchWaterPumpData() async {
    waterPumpRef.onValue.listen((DatabaseEvent event) {
      Map<String, dynamic> dataMap =
          Map<String, dynamic>.from(event.snapshot.value as Map);
      WaterPumpValue waterPumpValue = WaterPumpValue.fromJson(dataMap);
      waterPumpActive = waterPumpValue.waterPumpValueBool!;
      setState(() {});
    });
  }

  void _fetchPredictionData() async {
    predictionRef.onValue.listen((DatabaseEvent event) {
      Map<String, dynamic> dataMap =
          Map<String, dynamic>.from(event.snapshot.value as Map);
      PredictionValue predictionData = PredictionValue.fromJson(dataMap);
      predictionValue = predictionData.predictionValueList!;
      setState(() {});
    });
  }

  void _setWaterPumpValue(bool pumpActive) async {
    await waterPumpRef.set({
      "bool": !pumpActive,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(withBackButton: false,),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomElevatedButton(text: "Carrot", onPressed: () {}),
                    CustomElevatedButton(text: "Leeks", onPressed: () {}),
                    CustomElevatedButton(text: "Radish", onPressed: () {}),
                    CustomElevatedButton(text: "Pumpkin", onPressed: () {}),
                    CustomElevatedButton(text: "Tomato", onPressed: () {}),
                    CustomElevatedButton(text: "Barley", onPressed: () {}),
                    CustomElevatedButton(text: "Wheat", onPressed: () {}),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: primaryColorDark,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Marquee(
                  text: "🍀Auto farm predicts a ${(predictionValue*100).toStringAsFixed(2)} % increase in crop yield for the upcoming month 🌴",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomCircularPercentIndicator(
                        title: "Soil Moisture",
                        value: moistureSensorValue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => SensorView(),
                            ),
                          );
                        },
                      ),
                      CustomCircularPercentIndicator(
                        title: "Light Level",
                        value: lightSensorValue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  SensorView(sensorType: SensorType.Light),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomCircularPercentIndicator(
                        title: "Temparature",
                        value: temperatureSensorValue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => SensorView(
                                  sensorType: SensorType.Temperature),
                            ),
                          );
                        },
                      ),
                      CustomCircularPercentIndicator(
                        title: "Humidity",
                        value: humiditySensorValue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  SensorView(sensorType: SensorType.Humidity),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                  text: "Water-pump ${waterPumpActive ? "Active" : "Inactive"}",
                  textSize: 18,
                  bgColor: waterPumpActive?Colors.amber:primaryColor,
                  onPressed: () {
                    _setWaterPumpValue(waterPumpActive);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
