import 'package:flutter/material.dart';

class SizeMedia {
  static Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);

  static double screenWidth(BuildContext context) => screenSize(context).width;

  static double screenHeight(BuildContext context) =>
      screenSize(context).height;
}
