import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _enteredMessage = '';
  TextEditingController _controller = TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final currentUser = await FirebaseAuth.instance.currentUser();
    final userName = await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'username': userName['username'],
      'userImage': userName['image_url'],
    });
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                enableSuggestions: true,
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send The message'),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                }),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
