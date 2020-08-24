import 'dart:ui';

import 'package:flutter/material.dart';

Widget blurFilter() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
    ),
  );
}
