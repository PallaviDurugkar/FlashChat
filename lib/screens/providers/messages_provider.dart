import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messagesProvider = StreamProvider<List<Message>>((ref) {
  final _firestore = FirebaseFirestore.instance;
  return _firestore.collection('messages').orderBy('createdAt').snapshots().map(
        (event) => event.docs
            .map(
              (e) => Message.fromMap(
                e.data(),
              ),
            )
            .toList(),
      );
});
