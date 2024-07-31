import 'dart:convert';

class SensorData {
  HumiditySensor? humiditySensor;
  LightSensor? lightSensor;
  MoistureSensor? moistureSensor;
  PredictionValue? predictionValue;
  TempSensor? tempSensor;
  WaterPumpThreshold? waterPumpThreshold;
  WaterPumpValue? waterPumpValue;

  SensorData({
    this.humiditySensor,
    this.lightSensor,
    this.moistureSensor,
    this.predictionValue,
    this.tempSensor,
    this.waterPumpThreshold,
    this.waterPumpValue,
  });

  factory SensorData.fromRawJson(String str) => SensorData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SensorData.fromJson(Map<String, dynamic> json) => SensorData(
    humiditySensor: json["humiditySensor"] == null ? null : HumiditySensor.fromJson(json["humiditySensor"]),
    lightSensor: json["lightSensor"] == null ? null : LightSensor.fromJson(json["lightSensor"]),
    moistureSensor: json["moistureSensor"] == null ? null : MoistureSensor.fromJson(json["moistureSensor"]),
    predictionValue: json["predictionValue"] == null ? null : PredictionValue.fromJson(json["predictionValue"]),
    tempSensor: json["tempSensor"] == null ? null : TempSensor.fromJson(json["tempSensor"]),
    waterPumpThreshold: json["waterPumpThreshold"] == null ? null : WaterPumpThreshold.fromJson(json["waterPumpThreshold"]),
    waterPumpValue: json["waterPumpValue"] == null ? null : WaterPumpValue.fromJson(json["waterPumpValue"]),
  );

  Map<String, dynamic> toJson() => {
    "humiditySensor": humiditySensor?.toJson(),
    "lightSensor": lightSensor?.toJson(),
    "moistureSensor": moistureSensor?.toJson(),
    "predictionValue": predictionValue?.toJson(),
    "tempSensor": tempSensor?.toJson(),
    "waterPumpThreshold": waterPumpThreshold?.toJson(),
    "waterPumpValue": waterPumpValue?.toJson(),
  };
}

class HumiditySensor {
  Map<String, double>? humiditySensorValue;

  HumiditySensor({
    this.humiditySensorValue,
  });

  factory HumiditySensor.fromRawJson(String str) => HumiditySensor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HumiditySensor.fromJson(Map<String, dynamic> json) => HumiditySensor(
    humiditySensorValue: Map.from(json["humiditySensorValue"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "humiditySensorValue": Map.from(humiditySensorValue!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class LightSensor {
  Map<String, int>? lightSensorValue;

  LightSensor({
    this.lightSensorValue,
  });

  factory LightSensor.fromRawJson(String str) => LightSensor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LightSensor.fromJson(Map<String, dynamic> json) => LightSensor(
    lightSensorValue: Map.from(json["lightSensorValue"]!).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "lightSensorValue": Map.from(lightSensorValue!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class MoistureSensor {
  Map<String, double>? moistureSensorValue;

  MoistureSensor({
    this.moistureSensorValue,
  });

  factory MoistureSensor.fromRawJson(String str) => MoistureSensor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoistureSensor.fromJson(Map<String, dynamic> json) => MoistureSensor(
    moistureSensorValue: Map.from(json["moistureSensorValue"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "moistureSensorValue": Map.from(moistureSensorValue!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class PredictionValue {
  double? predictionValueList;

  PredictionValue({
    this.predictionValueList,
  });

  factory PredictionValue.fromRawJson(String str) => PredictionValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PredictionValue.fromJson(Map<String, dynamic> json) => PredictionValue(
    predictionValueList: json["predictionValueList"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "predictionValueList": predictionValueList,
  };
}

class TempSensor {
  Map<String, double>? tempSensorValue;

  TempSensor({
    this.tempSensorValue,
  });

  factory TempSensor.fromRawJson(String str) => TempSensor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TempSensor.fromJson(Map<String, dynamic> json) => TempSensor(
    tempSensorValue: Map.from(json["tempSensorValue"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "tempSensorValue": Map.from(tempSensorValue!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class WaterPumpThreshold {
  double? soilMoisturePresetValue;

  WaterPumpThreshold({
    this.soilMoisturePresetValue,
  });

  factory WaterPumpThreshold.fromRawJson(String str) => WaterPumpThreshold.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WaterPumpThreshold.fromJson(Map<String, dynamic> json) => WaterPumpThreshold(
    soilMoisturePresetValue: json["soilMoisturePresetValue"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "soilMoisturePresetValue": soilMoisturePresetValue,
  };
}

class WaterPumpValue {
  bool? waterPumpValueBool;

  WaterPumpValue({
    this.waterPumpValueBool,
  });

  factory WaterPumpValue.fromRawJson(String str) => WaterPumpValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WaterPumpValue.fromJson(Map<String, dynamic> json) => WaterPumpValue(
    waterPumpValueBool: json["bool"],
  );

  Map<String, dynamic> toJson() => {
    "bool": waterPumpValueBool,
  };
}
