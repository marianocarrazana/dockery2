import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/containers.dart';
import 'pages/images.dart';
import 'layouts/splitview.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  _page(RouteSettings settings, Widget child) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, a, __, c) =>
          FadeTransition(opacity: a, child: c));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'SAPP',
        theme: ThemeData(
            useMaterial3: true, colorScheme: const ColorScheme.dark()),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/images":
              return _page(settings, const SplitView(content: Images()));

            default: //containers
              return _page(settings, const SplitView(content: Containers()));
          }
        });
  }
}
