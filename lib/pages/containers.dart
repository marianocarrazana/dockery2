import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api_handler.dart';
import '../widgets/responsive_grid.dart';
import '../widgets/custom_container.dart';
import '../extensions.dart';

final containersProvider =
    FutureProvider.family<List, String>((ref, url) async {
  dynamic res = await apiGet(ref, "GET", url, queryParameters: {"all": "1"});
  return res;
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
            for (var container in config)
              CustomContainer(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(container["Names"][0]),
                    Text(
                      container["Id"],
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    Row(
                      children: [
                        Text(container["State"].toString().capitalize()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(container["Status"]),
                        )
                      ],
                    )
                  ]))
          ]);
        });
  }
}
