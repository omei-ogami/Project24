import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_24/models/message.dart';
import 'package:project_24/repositories/friends_message_repo.dart';

class FriendsMessagesViewModel with ChangeNotifier {
  final FriendsMessageRepository _friendsMessageRepository;
  StreamSubscription<List<Message>>? _messagesSubscription;

  List<Message> _messages = [];
  List<Message> get messages => _messages;
  bool _isInitializing = true;
  bool get isInitializing => _isInitializing;

  FriendsMessagesViewModel({FriendsMessageRepository? friendsMessageRepository, required String id, required String friendId})
      : _friendsMessageRepository = friendsMessageRepository ?? FriendsMessageRepository() {
    _messagesSubscription = _friendsMessageRepository.streamMessages(id, friendId).listen(
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

  Future<String> addMessage(String id, String friendId, Message newMessage) async {
    return await _friendsMessageRepository.addMessage(newMessage, id, friendId);
  }

  Future<void> deleteMessage(String messageId) async {
    await _friendsMessageRepository.deleteMessage(messageId);
  }
}
