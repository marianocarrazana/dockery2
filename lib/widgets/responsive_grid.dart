import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid(
      {super.key,
      required this.children,
      this.widthExpected = 480,
      this.heightExpected = 220});
  final List<Widget> children;
  final int widthExpected;
  final int heightExpected;

  @override
  Widget build(BuildContext context) {
    var columns = math.max(
        (MediaQuery.of(context).size.width ~/ widthExpected).toInt(), 1);
    var widthColumns = MediaQuery.of(context).size.width / columns;
    var aspectRatio = widthColumns / heightExpected;
    return GridView.count(
        crossAxisCount: columns,
        childAspectRatio: aspectRatio,
        padding: const EdgeInsets.all(2),
        children: children);
  }
}
