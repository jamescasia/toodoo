import 'package:flutter/material.dart';

/* Custom Scroll Behaviour to get rid of 
standard android end of scroll blue animation */
class CustomScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
