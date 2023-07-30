import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../states.dart';
import '../widgets/custom_container.dart';

class Sessions extends ConsumerWidget {
  const Sessions({super.key});

  void _setConfig(String newConfig) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('config', newConfig);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomContainer(
      hoverEffect: false,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConfigInput(configName: "Host"),
            ConfigInput(configName: "Username"),
            ConfigInput(configName: "Password", obscureText: true)
          ]),
    );
  }
}

class ConfigInput extends StatelessWidget {
  const ConfigInput({
    super.key,
    required this.configName,
    this.obscureText = false,
    this.labelText,
    this.hintText,
  });
  final String configName;
  final bool obscureText;
  final String? labelText;
  final String? hintText;

  void _setConfig(String newConfig) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(configName, newConfig);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onFieldSubmitted: (e) {
              _setConfig(e);
            },
            obscureText: obscureText,
            initialValue: "",
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: hintText,
              labelText: labelText ?? configName,
            ),
          )
        ]);
  }
}
