import 'package:flutter/material.dart';
import 'package:project_24/services/authentication.dart';
import 'package:project_24/services/push_messaging.dart';
import 'package:project_24/view_models/me_vm.dart';
import 'package:project_24/widgets/message_list.dart';
import 'package:project_24/widgets/new_message_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final PushMessagingService _pushMessagingService;

  @override
  void initState() {
    super.initState();

    final myId = Provider.of<MeViewModel>(context, listen: false).myId;
    _pushMessagingService =
        Provider.of<PushMessagingService>(context, listen: false);
    // Initialize `_pushMessagingService` without awaiting, so that the `build` method can run
    _pushMessagingService.initialize(
      userId: myId,
      topics: ['chat'],
    ).catchError((e) {
      debugPrint('Error initializing push messaging service: $e');
    });
  }

  @override
  void dispose() {
    // Do NOT unsubscribe from the topic here, as the user may want to receive notifications even when the app is in the background
    // _pushNotificationService.unsubscribeFromAllTopics();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<PushMessagingService>(context, listen: false)
                  .unsubscribeFromAllTopics();
              Provider.of<AuthenticationService>(context, listen: false)
                  .logOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: MessageList(),
          ),
          NewMessageBar(),
        ],
      ),
    );
  }
}