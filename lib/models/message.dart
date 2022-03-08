
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final String sender;
  final Timestamp createdAt;

  Message({
    required this.text,
    required this.sender,
    required this.createdAt,
  });



  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'createdAt': createdAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'],
      sender: map['sender'] ,
      createdAt: map['createdAt'],
    );
  }


}
