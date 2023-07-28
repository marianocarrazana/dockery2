import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/custom_container.dart';
import '../states.dart';

class AppMenu extends ConsumerWidget {
  AppMenu({super.key, this.hue});
  final double? hue;
  final List _pageList = [
    {'title': 'Containers', 'route': '/containers'},
    {'title': 'Images', 'route': '/images'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomContainer(
        margin: 12,
        child: ListView(children: <Widget>[
          // iterate through the keys to get the page names
          for (var page in _pageList)
            Material(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                type: MaterialType.transparency,
                child: ListTile(
                    hoverColor: Colors.white12,
                    selectedColor: Colors.white,
                    textColor: Colors.white70,
                    titleTextStyle: Theme.of(context).textTheme.titleLarge,
                    title: Text(page['title']),
                    selected: ref.watch(currentPage) == page['route'],
                    onTap: () {
                      ref.read(currentPage.notifier).state = page['route'];
                      Navigator.pushNamed(context, page['route']);
                    }))
        ]));
  }
}
