import 'package:google_docs_clone/client/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepository {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void joinRoom(String documentID) {
    _socketClient.emit("join", documentID);
  }

  void typing(Map<String, dynamic> data) {
    _socketClient.emit("typing", data);
  }

  void autoSave(Map<String, dynamic> data) {
    _socketClient.emit("save", data);
  }

  void changeListener(Function(Map<String, dynamic>) func) {
    _socketClient.on("changes", (data) => func(data));
  }

  // On it used to send data from the server to the client  ---> Server emits to client
  // emit is used to send data from the client to the server ---> Client emits to server
}
