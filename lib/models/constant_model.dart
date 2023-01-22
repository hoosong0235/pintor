import 'package:flutter/material.dart';

const List<Color> colorOptions = [
  Colors.pink,
  Colors.purple,
  Colors.indigo,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.red,
];
const List<String> colorText = [
  "Pink",
  "Purple",
  "Indigo",
  "Blue",
  "Green",
  "Yellow",
  "Orange",
  "Red",
  "Pink",
];

const TextStyle largeTextStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w500,
);
const TextStyle mediumTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
const TextStyle smallTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w300,
);

const SizedBox largeSizedBox = SizedBox(
  width: 32,
  height: 32,
);
const SizedBox mediumSizedBox = SizedBox(
  width: 16,
  height: 16,
);
const SizedBox smallSizedBox = SizedBox(
  width: 12,
  height: 12,
);

const EdgeInsets largeEdgeInsets = EdgeInsets.all(32);
const EdgeInsets mediumEdgeInsets = EdgeInsets.all(16);
const EdgeInsets smallEdgeInsets = EdgeInsets.all(8);

const RoundedRectangleBorder userMessageBoreder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
    topLeft: Radius.circular(12),
  ),
);
const RoundedRectangleBorder botMessageBoreder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
    topRight: Radius.circular(12),
  ),
);
