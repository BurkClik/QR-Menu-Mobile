import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFF93F7E);
const kSecondColor = Color(0xFFFC8B8E);

//==================================
// AppBar
//==================================
const kAppBarCafeText = TextStyle(
  fontFamily: 'Cinzel',
  fontSize: 28,
  color: Colors.black,
);

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

const kSignHintText = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 12.0,
);

const kSignAuthHintText = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 12.0,
  color: kPrimaryColor,
);

//====================================
// Waiter Page
//====================================
const kLastActivitiesText = TextStyle(
  color: kSecondColor,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 16,
  decoration: TextDecoration.underline,
);

const kItemBoxShadow = BoxShadow(
  color: Color(0x40000000),
  blurRadius: 4,
  offset: Offset(0, 4),
);

const kOrderDetailText = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
);

const kOrderTimeText = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 12,
  color: kBlackWithOpacity,
);

//========================
// Admin Page
//========================
const kDrawerText = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
);

//========================
// Admin Home
//========================
const kDailyText = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w700,
  fontSize: 16,
  color: Color(0xFFD133B8),
);

const kDailyTextCount = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 32,
);

const kTableTitle = TextStyle(
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w700,
  fontSize: 16.0,
  color: Color(0xFF3398D1),
);

const kTableCellStyle = TextStyle(
  fontFamily: 'Kodchasan',
  fontSize: 12.0,
  fontWeight: FontWeight.w800,
);
