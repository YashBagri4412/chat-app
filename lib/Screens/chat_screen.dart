//Relative Import
import 'package:chatapp/Widgets/chats/message.dart';
import 'package:chatapp/Widgets/chats/new_messages.dart';
//package import
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (message) {
        print(message);
        return;
      },
      onLaunch: (message) {
        print(message);
        return;
      },
      onResume: (message) {
        print(message);
        return;
      },
    );
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
                value: 'logout',
              ),
            ],
            onChanged: (value) {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Message(),
          ),
          NewMessages(),
        ],
      ),
    );
  }
}
