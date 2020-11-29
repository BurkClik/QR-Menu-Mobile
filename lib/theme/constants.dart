import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFF93F7E);

//==================================
// Sign In and Out
//==================================
const kBlackWithOpacity = Color(0x80000000);
const kBlackOpacityInput = Color(0x59000000);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFA578E), Color(0xFFFDAA8E)],
);

const kWelcomeText = TextStyle(
  fontSize: 28,
  fontFamily: 'Kodchasan',
);

const kWelcomeHintText = TextStyle(
  fontSize: 16,
  fontFamily: 'Kodchasan',
  color: kBlackWithOpacity,
);

const kSignInputLabel = TextStyle(
  fontSize: 16.0,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  color: kBlackOpacityInput,
);

const kSignInOutText = TextStyle(
  color: Colors.white,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 20.0,
);
