import 'package:flash_chat/models/message.dart';
import 'package:flash_chat/repositories/messages_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



final messagesProvider = StreamProvider<List<Message>>((ref)=>ref.read(messagesRepositoryProvider).messageStream());
