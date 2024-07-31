import 'package:autofarm/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularPercentIndicator extends StatelessWidget {
  final String title;
  final double value;
  final VoidCallback? onTap;

  const CustomCircularPercentIndicator({
    Key? key,
    this.title = "N/A",
    this.value = 1.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 60,
              animation: true,
              animationDuration: 2000,
              lineWidth: 15,
              percent: value>0?value/100:0,
              center: Text(value.toString()),
              reverse: false,
              arcType: ArcType.FULL,
              startAngle: 0.0,
              animateFromLastPercent: false,
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: backupColor,
              linearGradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.clamp,
                stops: [0.0, 0.5,1.0],
                colors: <Color>[
                  thirdColor,
                  secondaryColor,
                  primaryColor,
                ],
              ),
              arcBackgroundColor:value<0?Colors.amber:Colors.white,
            ),
            SizedBox(height: 10,),
            Text(this.title),
          ],
        ),
      ),
    );
  }
}
