import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_24/models/message.dart';
import 'package:project_24/repositories/message_repo.dart';

class AllMessagesViewModel with ChangeNotifier {
  final MessageRepository _messageRepository;
  StreamSubscription<List<Message>>? _messagesSubscription;

  List<Message> _messages = [];
  List<Message> get messages => _messages;
  bool _isInitializing = true;
  bool get isInitializing => _isInitializing;

  AllMessagesViewModel({MessageRepository? messageRepository, required String id})
      : _messageRepository = messageRepository ?? MessageRepository() {
    _messagesSubscription = _messageRepository.streamMessages(id).listen(
      (messages) {
        _isInitializing = false;
        _messages = messages;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }

  Future<String> addMessage(String id, Message newMessage) async {
    return await _messageRepository.addMessage(newMessage, id);
  }

  Future<void> deleteMessage(String messageId) async {
    await _messageRepository.deleteMessage(messageId);
  }
}
