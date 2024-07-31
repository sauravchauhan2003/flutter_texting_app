import 'package:chatapp/components/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/chat services/message_services.dart';

class ChatPage extends StatefulWidget {
  final String useremail;
  final String receiveremail;
  const ChatPage(
      {super.key, required this.useremail, required this.receiveremail});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageService = MessageServices();
  final messagetextcontroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  String messagetext = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveremail),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection(MessageServices()
                        .ChatRoomid(widget.useremail, widget.receiveremail))
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Material(
                          color: Colors.lightBlueAccent,
                          child: Text('No messages here')),
                    );
                  }
                  final messages = snapshot.data?.docs;
                  List<MessageBubble> messagewidgetlist = [];
                  for (var message in messages!) {
                    final messagetext = message['text'];
                    final messagesender = message['sender'];
                    final messagewidget = MessageBubble(
                      sender: messagesender,
                      text: messagetext,
                      user: messagesender == widget.useremail ? 1 : 0,
                    );
                    messagewidgetlist.add(messagewidget);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: messagewidgetlist,
                    ),
                  );
                }),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        {
                          messagetextcontroller.clear();
                          _firestore
                              .collection(MessageServices().ChatRoomid(
                                  widget.useremail, widget.receiveremail))
                              .add({
                            'sender': widget.useremail,
                            'text': messagetext,
                            'timestamp': Timestamp.now()
                          });
                          messageService.getMessages(MessageServices()
                              .ChatRoomid(
                                  widget.useremail, widget.receiveremail));
                        }
                      });
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
