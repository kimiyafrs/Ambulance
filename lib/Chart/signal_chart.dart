import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SignalChart extends StatelessWidget {
  final List<FlSpot> signals;

  SignalChart({required this.signals}){
    print("Received signals in SignalChart: $signals");
  }

  @override
  Widget build(BuildContext context) {
    print("Received signals in SignalChart: $signals");
    if (signals.isEmpty) {
      return Center(
        child: Text(
          'No signals available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return LineChart(
      LineChartData(
        minY: signals.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 150,
        maxY: signals.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 150,
        minX: signals.first.x,
        maxX: signals.last.x,
        // gridData: FlGridData(
        //   show: true,
        //   drawVerticalLine: true,
        //   horizontalInterval: 500,
        //   verticalInterval: 100,
        // ),
        // titlesData: FlTitlesData(
        //   leftTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       reservedSize: 40,
        //       interval: 100,
        //       getTitlesWidget: (value, meta) {
        //         return Text(value.toInt().toString());
        //       },
        //     ),
        //   ),
        //   bottomTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       reservedSize: 30,
        //       interval: 20,
        //       getTitlesWidget: (value, meta) {
        //         return Text(value.toInt().toString());
        //       },
        //     ),
        //   ),
        // ),
        // borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: signals,
            color: Colors.indigo,
            isCurved: true,
            barWidth: 1,
            // belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
