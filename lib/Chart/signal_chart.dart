import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class SignalChart extends StatelessWidget {
  final List<FlSpot> signals;

  SignalChart({required this.signals}) {
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: signals.length * 5.0,
        child: LineChart(
          LineChartData(
            // baselineX: 50,
            // baselineY: 100,
            // minY:  signals.map((s) => s.y).reduce((a, b) => a < b ? a : b),// - 150,
            // maxY: signals.map((s) => s.y).reduce((a, b) => a > b ? a : b),// + 150,
            minX:0,// signals.first.x,
            maxX: signals.length.toDouble(),// signals.last.x,
                    gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          // horizontalInterval: 500,
          // verticalInterval: 100,
        ),
            titlesData: FlTitlesData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: signals,
                color: Colors.green.shade800,
                isCurved: true,
                barWidth: 1.5,
                dotData: FlDotData(show: false,),
                aboveBarData:  BarAreaData(show: false) ,
                belowBarData: BarAreaData(show: false) ,
                isStrokeCapRound: false,

                // isStepLineChart: true,
                // lineChartStepData: LineChartStepData(stepDirection: 0.1),
                // curveSmoothness: 0.1,

              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SignalChart extends StatelessWidget {
//   final List<FlSpot> signals;
//
//   SignalChart({required this.signals}){
//     print("Received signals in SignalChart: $signals");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("Received signals in SignalChart: $signals");
//     if (signals.isEmpty) {
//       return Center(
//         child: Text(
//           'No signals available',
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//       );
//     }
//
//     return LineChart(
//       LineChartData(
//         minY: signals.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 150,
//         maxY: signals.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 150,
//         minX: signals.first.x,
//         maxX: signals.last.x,
//         // gridData: FlGridData(
//         //   show: true,
//         //   drawVerticalLine: true,
//         //   horizontalInterval: 500,
//         //   verticalInterval: 100,
//         // ),
//         // titlesData: FlTitlesData(
//         //   leftTitles: AxisTitles(
//         //     sideTitles: SideTitles(
//         //       showTitles: true,
//         //       reservedSize: 40,
//         //       interval: 100,
//         //       getTitlesWidget: (value, meta) {
//         //         return Text(value.toInt().toString());
//         //       },
//         //     ),
//         //   ),
//         //   bottomTitles: AxisTitles(
//         //     sideTitles: SideTitles(
//         //       showTitles: true,
//         //       reservedSize: 30,
//         //       interval: 20,
//         //       getTitlesWidget: (value, meta) {
//         //         return Text(value.toInt().toString());
//         //       },
//         //     ),
//         //   ),
//         // ),
//         // borderData: FlBorderData(show: true),
//         lineBarsData: [
//           LineChartBarData(
//             spots: signals,
//             color: Colors.indigo,
//             isCurved: true,
//             barWidth: 1,
//             // belowBarData: BarAreaData(show: false),
//           ),
//         ],
//       ),
//     );
//   }
// }
