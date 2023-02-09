import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, this.isMe, this.userName, this.userImage,
      {super.key});

  final String message;
  final String userName;
  final bool isMe;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            right: isMe ? 115 : null,
            left: !isMe ? 5 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            )),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomLeft: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  )),
              width: 145,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.white : Colors.black),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
