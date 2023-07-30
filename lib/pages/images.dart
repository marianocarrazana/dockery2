import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../api_handler.dart';
import '../widgets/responsive_grid.dart';
import '../widgets/custom_container.dart';

final imagesProvider = FutureProvider.family<List, String>((ref, url) async {
  List res = await apiGet(ref, "GET", url);
  return res;
});

class Images extends ConsumerWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List> images = ref.watch(imagesProvider("images"));
    return images.when(
        loading: () => const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
        error: (err, stack) => Text('Error: $err'),
        data: (_) {
          return ResponsiveGrid(children: [
            for (var image in _)
              CustomContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    image["Id"],
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  Text(image["RepoTags"][0])
                ],
              ))
          ]);
        });
  }
}
