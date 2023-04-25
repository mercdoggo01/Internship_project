import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flut the Chatbot',
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
  String _currentTime = "";

  //A function to update the current time
  void _updateCurrentTime() {
    setState(() {
      _currentTime = DateFormat.jm().format(DateTime.now());
    });
  }

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
  }

  final List<ChatMessage> _messages = <ChatMessage>[
    ChatMessage(text: 'Hi there! How can I help you?'),
  ];

  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _generateResponse(text);
  }

  void _generateResponse(String question) {
    String response;
    if (question.toLowerCase().contains('operating hours')) {
      response = 'Our operating hours are from 9AM to 5PM, Monday to Friday.';
    } else if (question.toLowerCase().contains('contact')) {
      response =
          'You can contact us through our email at support@example.com or through our hotline at 1-800-123-4567.';
    } else if (question.toLowerCase().contains('hi') ||
        question.toLowerCase().contains('hey') ||
        question.toLowerCase().contains('hello')) {
      response = 'Hello there !, today seems a nice day for a little chit-chat';
    } else if (question.toLowerCase().contains('how are you')) {
      response = 'I\'m very full functional and operational. How about you ?';
    } else if (question.toLowerCase().contains('time') ||
        question.toLowerCase().contains('date') ||
        question.toLowerCase().contains('today')) {
      String dateStr = DateTime.now().toString();
      response =
          'According to your local system the current date and time is ${dateStr}';
    } else if (question.toLowerCase().contains('hate me') ||
        question.toLowerCase().contains('hate me')) {
      response = 'I\'m an AI so, I don\'t have feelings like humans.';
    } else if (question.toLowerCase().contains('are you smart') ||
        question.toLowerCase().contains('can you upgrade')) {
      response =
          'I\'m an AI hence, my intelligence is programmed. Although, I can be better with future upgrades.';
    } else if (question.toLowerCase().contains('animal you like') ||
        question.toLowerCase().contains('favourite animal')) {
      response = 'Seeing a Doggo sure is a nice';
    } else if (question.toLowerCase().contains('creator') ||
        question.toLowerCase().contains('your master')) {
      response = 'Anirban Ganguly created me';
    } else if (question.toLowerCase().contains('version') ||
        question.toLowerCase().contains('build')) {
      response = 'My current build is v1.0.0.';
    } else if (question.toLowerCase().contains('joke') ||
        question.toLowerCase().contains('funny')) {
      response = 'They say AI will take over the world :-)';
    } else if (question.toLowerCase().contains('flutter') ||
        question.toLowerCase().contains('framework')) {
      response =
          'Flutter is a framework developed by Google which uses Dart programming language to create seamless applications for web mobiles and tablets';
    } else {
      response = 'I\'m sorry, I don\'t understand your question.';
    }
    ChatMessage message = ChatMessage(text: response);
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff170885),
        title: Text('Flutter Chatbot Demo'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xffa488ff),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(_currentTime),
          ),
          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        color: Color(0xff9f03f2),
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
                color: Color(0xff1b1a1a),
              ),
              decoration: BoxDecoration(
                color: Color(0xff42a3f2),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, this.isUser = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isUser ? Color(0xff05149a) : Color(0xff400490),
                borderRadius: isUser
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
