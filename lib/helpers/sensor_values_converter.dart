double convertSensorValueToPercentage(num sensorValue) {
  // Ensure the sensorValue is within the expected range
  if (sensorValue < -100) sensorValue = -100;
  if (sensorValue > 100) sensorValue = 100;

  // Normalize the sensorValue to the range [0, 1]
  final x= (sensorValue + 100) / 200;
  return double.parse(x.toStringAsFixed(2));
}
