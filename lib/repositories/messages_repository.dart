import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/message.dart';
import '../screens/providers/auth_provider.dart';

final messagesRepositoryProvider = Provider((ref) => MessagesRepository(ref));

class MessagesRepository {
  final Ref ref;
  MessagesRepository(this.ref);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User get  _user => ref.read(authProvider).user!;
  

  void sendMessage(String text) {
    _firestore.collection('messages').add(
          Message(
                  text: text,
                  sender: _user.email!,
                  createdAt: Timestamp.now())
              .toMap(),
        );
  }

  Stream<List<Message>> messageStream(){
  return _firestore.collection('messages').orderBy('createdAt').snapshots().map(
        (event) => event.docs
            .map(
              (e) => Message.fromMap(
                e.data(),
              ),
            )
            .toList(),
      );
  }
}
