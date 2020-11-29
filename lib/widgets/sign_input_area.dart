import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';

class SignInputArea extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget prefixIcon;
  final String labelText;

  SignInputArea({this.textEditingController, this.labelText, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(304),
      height: getProportionateScreenHeight(48),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: kSignInputLabel,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
