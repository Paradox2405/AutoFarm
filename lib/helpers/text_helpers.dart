import 'enums.dart';

String getSensorTypeString(SensorType sensorType) {
  switch (sensorType) {
    case SensorType.Humidity:
      return "Humidity Sensor";
    case SensorType.Temperature:
      return "Temperature Sensor";
    case SensorType.Light:
      return "Light Sensor";
    case SensorType.Moisture:
      return "Moisture Sensor";
    default:
      return "Unknown Sensor";
  }
}
