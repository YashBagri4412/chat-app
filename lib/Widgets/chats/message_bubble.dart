import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String username;
  final bool isMe;
  final String userImage;
  final Key key;
  MessageBubble(this.messageText, this.isMe, this.username, this.userImage,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username ?? 'error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    messageText,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(15),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              width: 140,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
            ),
          ],
        ),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
          left: isMe ? null : 130,
          right: isMe ? 130 : null,
          top: -10,
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
