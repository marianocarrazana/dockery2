import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../api_handler.dart';
import '../widgets/responsive_grid.dart';
import '../widgets/custom_container.dart';

final containersProvider =
    FutureProvider.family<List, String>((ref, url) async {
  dynamic res = await apiGet("GET", url, ref);
  return [];
});

class Containers extends ConsumerWidget {
  const Containers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List> containers = ref.watch(containersProvider("containers"));
    return containers.when(
        loading: () => const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
        error: (err, stack) => Text('Error: $err'),
        data: (config) {
          return ResponsiveGrid(children: [
            for (var container in config) CustomContainer(child: Text("data"))
          ]);
        });
  }
}
