
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() => runApp(MyApp());

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  
  @override
  void initState() {
    super.initState();
    socket = IO.io('http://localhost:3000', 
      IO.OptionBuilder().setTransports(['websocket']).build());
    
    socket.on('new_message', (data) {
      // تحديث واجهة المستخدم
    });
  }
}
