import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _userEnterMessage,
      'time': Timestamp.now(),
      'userID': user.uid,
      'userName': userData.data()!['userName'],
      'userImage': userData['pickedImage'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
            child: TextField(
          maxLines: null,
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Send a message...'),
          onChanged: (value) {
            setState(() {
              _userEnterMessage = value;
            });
          },
        )),
        IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            color: Colors.blue,
            icon: const Icon(Icons.send))
      ]),
    );
  }
}
