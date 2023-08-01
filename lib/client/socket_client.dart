import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;

  static SocketClient? _instance;

  SocketClient._internal() {}

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
