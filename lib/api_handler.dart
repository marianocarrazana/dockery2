import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

SSHClient? sshclient;

Future<dynamic> apiGet(Ref ref, String method, String path,
    {Map<String, dynamic>? queryParameters}) async {
  final prefs = await SharedPreferences.getInstance();
  var client = sshclient;
  if (client == null) {
    log("Creating connection...");
    client = SSHClient(
      await SSHSocket.connect(prefs.getString("Host") ?? "", 22),
      username: prefs.getString("Username") ?? "",
      onPasswordRequest: () => prefs.getString("Password"),
    );
    sshclient = client;
  }
  final Uri uri = Uri.http('localhost', '/v1.25/$path/json', queryParameters);
  final Uint8List output = await client
      .run('curl --unix-socket /var/run/docker.sock "$uri"', stderr: false);
  String decoded = utf8.decode(output);
  dynamic obj = jsonDecode(decoded);
  return obj;
}
