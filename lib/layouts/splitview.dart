import 'package:flutter/material.dart';

import 'menu.dart';

class SplitView extends StatelessWidget {
  const SplitView({Key? key, required this.content}) : super(key: key);
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double menuWidth = 240;
    if (screenWidth >= 600) {
      // desktop
      return Scaffold(
          body: Row(
        children: [
          SizedBox(
            width: menuWidth,
            child: AppMenu(),
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Expanded(child: content)]),
          ),
        ],
      ));
    } else {
      // mobile
      return Scaffold(
        body: content,
        appBar: AppBar(
          title: const Text('Dockery 2'),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        drawer: SizedBox(
          width: menuWidth,
          child: Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: AppMenu(),
          ),
        ),
      );
    }
  }
}
