import 'package:flutter/material.dart';

import '../main.dart';

final primaryColor = Color(0x73000000);
final tWalletColor = Color(0xDD000000);
final colorLight = Color(0x42000000);
final colorDark = Color(0x8A000000);

final baseColor = Color(0xFFFFFFFF);
final backgroundColor = Color(0xFFECEFF1);

const COLORINDICATORW = Color(0xff505050);

//Home
final homeTextStyle = TextStyle(color: primaryColor);

//PieChart
var BOXDECORATION = BoxDecoration(
  color: selectedTheme == 'Themee.dark'
      ? Color.fromARGB(232, 31, 31, 31)
      : Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(15)),
);

//Statistics
final buyColor = Color(0xFF29abe2);
final sellColor = Color(0xFFFF1744);
final colorLineChart = Color(0xFFFFA726);
final colorGradient1 = Color(0xFFFFCC80);
final colorGradient2 = Color(0xFFE65100);

const CHIPDECORATION = BoxDecoration(
  color: Color(0xFFB0BEC5),
  borderRadius: BorderRadius.all(Radius.circular(5)),
);
