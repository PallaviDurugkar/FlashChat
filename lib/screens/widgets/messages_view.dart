import 'package:flash_chat/screens/providers/auth_provider.dart';
import 'package:flash_chat/screens/providers/messages_provider.dart';
import 'package:flash_chat/screens/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: use_key_in_widget_constructors
class MessagesView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    final messagesAsync = ref.watch(messagesProvider);
    return Expanded(
      child: messagesAsync.when(
        data: (messages) => ListView(
          reverse: true,
          children: messages.reversed
              .map(
                (e) => MessageBubble(
                  sender: e.sender,
                  text: e.text,
                  isMe: auth.user!.email == e.sender,
                ),
              )
              .toList(),
        ),
        error: (e, s) => Center(
          child: Text('$e'),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
