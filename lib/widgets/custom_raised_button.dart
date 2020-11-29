import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';

class CustomRaisedButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  CustomRaisedButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: kPrimaryGradientColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: getProportionateScreenWidth(304.0),
            maxHeight: getProportionateScreenHeight(48.0),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: kSignInOutText,
          ),
        ),
      ),
    );
  }
}
