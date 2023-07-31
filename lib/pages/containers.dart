import 'package:dockery2/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
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

  List<Widget> _getList(_, BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> widgets = [];
    for (var container in _) {
      bool running = container["State"] == "running";
      String state = container["State"];
      var cont = CustomContainer(
          borderColor: running ? theme.colorScheme.primary : null,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  container["Names"][0].toString().replaceAll("/", ""),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  container["Id"],
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                Row(
                  children: [
                    Text(
                      state.capitalize(),
                      style: TextStyle(
                          color: running ? theme.colorScheme.primary : null),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(container["Status"]),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onPressed: () => null,
                      icon: running
                          ? CupertinoIcons.stop_fill
                          : CupertinoIcons.play_arrow_solid,
                      color:
                          running ? Colors.redAccent : Colors.lightGreenAccent,
                    ),
                    CustomButton(
                      onPressed: () => null,
                      icon: CupertinoIcons.restart,
                      color: Colors.yellow,
                    ),
                    CustomButton(
                      onPressed: () => null,
                      icon: CupertinoIcons.doc_plaintext,
                      color: Colors.blue,
                    ),
                  ],
                )
              ]));
      widgets.add(cont);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List> containers = ref.watch(containersProvider("containers"));
    return containers.when(
        loading: () => const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
        error: (err, stack) => Text('Error: $err'),
        data: (_) {
          return ResponsiveGrid(children: _getList(_, context));
        });
  }
}
