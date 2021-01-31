import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';

class DailyContainer extends StatelessWidget {
  final String dailyText;
  final String dailyCount;

  const DailyContainer({Key key, this.dailyText, this.dailyCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 40.0,
        top: 8.0,
        bottom: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dailyText,
            style: kDailyText,
          ),
          Text(
            dailyCount,
            style: kDailyTextCount,
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFFC8B8E), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.25),
            )
          ]),
    );
  }
}
