import 'package:flash_chat/models/message.dart';
import 'package:flash_chat/screens/providers/auth_provider.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/widgets/messages_view.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


// ignore: use_key_in_widget_constructors
class ChatScreen extends HookConsumerWidget {
  static const String id = 'chat_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    final controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(Icons.close),
              onPressed: () {
                auth.signOut();
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);
              }),
        ],
        // ignore: prefer_const_constructors
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesView(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('messages').add(
                        Message(text: controller.text, sender: auth.user!.email!, createdAt: Timestamp.now()).toMap()
                      );
                      controller.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
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
