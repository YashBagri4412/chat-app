import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//Relative imports
import '../chats/message_bubble.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final mesDocs = snapshot.data.documents;

            return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, index) => MessageBubble(
                mesDocs[index]['text'],
                mesDocs[index]['userId'] == futureSnapshot.data.uid,
                mesDocs[index]['username'],
                mesDocs[index]['userImage'],
                key: ValueKey(
                  mesDocs[index].documentID,
                ),
              ),
              itemCount: mesDocs.length,
            );
          },
        );
      },
    );
  }
}
