import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSH {
  const SSH({this.client});
  final SSHClient? client;
}

class SSHProxy extends StateNotifier<SSH> {
  SSHProxy() : super(const SSH());
  void setClient(SSHClient newClient) async {
    state = SSH(client: newClient);
  }
}

final sshProvider = StateNotifierProvider<SSHProxy, SSH>((ref) {
  return SSHProxy();
});

Future<dynamic> apiGet(String method, String url, Ref ref) async {
  if (ref.read(sshProvider).client == null) {
    final newClient = SSHClient(
      await SSHSocket.connect('localhost', 22),
      username: '',
      onPasswordRequest: () => '',
    );
    ref.read(sshProvider.notifier).setClient(newClient);
  }
  SSHClient? client = ref.read(sshProvider).client;
  if (client == null) return null;
  client.algorithms;
  final output = await client.run(
      'curl --unix-socket /var/run/docker.sock "http://localhost/v1.25/$url/json?all=1"',
      stderr: false);
  String decoded = utf8.decode(output);
  dynamic obj = jsonDecode(decoded);
  return obj;
}
