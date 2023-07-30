import 'package:dockery2/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../states.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  void _setConfig(String newConfig) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('config', newConfig);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<String> token = ref.watch(configProvider);
    return token.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (_config) {
          return CustomContainer(
            hoverEffect: false,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onFieldSubmitted: (e) {
                      _setConfig(e);
                      ref.refresh(configProvider);
                    },
                    initialValue: _config,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  )
                ]),
          );
        });
  }
}
