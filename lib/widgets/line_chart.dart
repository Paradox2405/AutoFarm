import 'package:autofarm/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomLineChart extends StatelessWidget {
  final List<double> data;

  CustomLineChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: true,touchTooltipData: LineTouchTooltipData( getTooltipColor: (touchedSpot) => thirdColorChart,)),
        minX: 0,
        maxX: data.length.toDouble() - 1,
        minY: -10,
        maxY: 100,
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(reservedSize: 44, showTitles: true)),
          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: secondaryColor),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: true,
            color: primaryColor,
            barWidth: 2,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: true, color: thirdColorChart),
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

