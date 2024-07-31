import 'package:autofarm/helpers/app_colors.dart';
import 'package:autofarm/helpers/enums.dart';
import 'package:autofarm/widgets/app_bar.dart';
import 'package:autofarm/widgets/elevated_button.dart';
import 'package:autofarm/widgets/line_chart.dart';
import 'package:autofarm/widgets/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../helpers/sensor_values_converter.dart';
import '../../helpers/text_helpers.dart';
import '../../modals/sensor_data_modal.dart';

class SensorView extends StatefulWidget {
  SensorType sensorType;
  SensorView({super.key, this.sensorType = SensorType.Moisture});

  @override
  State<SensorView> createState() => _SensorViewState();
}

class _SensorViewState extends State<SensorView> {
  DatabaseReference waterPumpRef =
      FirebaseDatabase.instance.ref('waterPumpValue');
  DatabaseReference waterpumpThresholdRef =
      FirebaseDatabase.instance.ref('waterPumpThreshold');
  DatabaseReference moistureSensorRef =
  FirebaseDatabase.instance.ref('moistureSensor/moistureSensorValue');
  List<double> sensorDataList = [];
  double finalSensorValue = 0.0;
  bool waterPumpActive = false;
  double _sliderValue = 50.0; // Initial value for the slider

  @override
  void initState() {
    super.initState();
    _setSliderValue();
    _fetchSensorData();
    _fetchWaterPumpData();
  }

  void _fetchSensorData() async {
    moistureSensorRef.onValue.listen((DatabaseEvent event) {
      sensorDataList.clear();
      final data = event.snapshot.value;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(data as Map);
      for (final data in dataMap.values) {
        sensorDataList.add(data);
      }
      finalSensorValue = dataMap.entries.last.value;
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

  void _setWaterPumpValue(bool pumpActive) async {
    await waterPumpRef.set({
      "bool": !pumpActive,
    });
  }

  void _setSliderValue() async {
    final snapshot = await waterpumpThresholdRef.get();
    if (snapshot.exists) {
      Map<String, dynamic> dataMap =
      Map<String, dynamic>.from(snapshot.value as Map);
      WaterPumpThreshold waterPumpThreshold = WaterPumpThreshold.fromJson(dataMap);
      _sliderValue=waterPumpThreshold.soilMoisturePresetValue!;
      setState(() {});
    }
  }


  void _onSliderChange(double sliderValue) async {
    setState(() {
      _sliderValue = sliderValue;
    });
    await waterpumpThresholdRef.update({
      "soilMoisturePresetValue": double.parse(sliderValue.toStringAsFixed(2)),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(withBackButton: true,),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              CustomCircularPercentIndicator(
                  title: getSensorTypeString(widget.sensorType),
                  value: finalSensorValue),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Preset: ${_sliderValue.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Slider(
                min: -0.5,
                max: 100.0,
                value: _sliderValue,
              activeColor: secondaryColor,
              thumbColor: thirdColor,
                onChanged: (value) {
                  _onSliderChange(value);
                },
              ),
              SizedBox(
                height: 15,
              ),
              const Text(
                'History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: CustomLineChart(data: sensorDataList,)
              ),
              SizedBox(
                height: 10,
              ),
              CustomElevatedButton(
                bgColor: waterPumpActive?Colors.amber:primaryColor,
                  textSize: 18,
                      text:
                          "Water-pump ${waterPumpActive ? "Active" : "Inactive"}",
                      onPressed: () {
                        _setWaterPumpValue(waterPumpActive);
                      })
            ],
          ),
        ),
      ),
    );
  }
}
