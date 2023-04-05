import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(ChatbotApp());

class ChatbotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  TextEditingController _textController = TextEditingController();

  void _sendMessage(String text) async {
    _textController.clear();
    setState(() {
      _messages.add(Message(text: text, isUser: true));
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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', // Replace with your API key
      },
      body: json.encode({
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': text},
        ],
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String reply = data['choices'][0]['message']['content'];
      setState(() {
        _messages.add(Message(text: reply, isUser: false));
      });
    } else {
      print('Failed to send message: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
          title: const Text('AI Chatbot'),
          centerTitle: true,
          backgroundColor: Color(0xff0ab310)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                Message message = _messages[index];
                return ListTile(
                  title: Text(message.text),
                  subtitle: Text(message.isUser ? 'You' : 'Bot'),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _sendMessage,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
