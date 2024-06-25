import 'package:flutter/material.dart';
import 'package:project_24/models/friend.dart';
import 'friend_item.dart';

class HomeFriendsTab extends StatelessWidget {
  const HomeFriendsTab({
    super.key,
    required this.friends,
    //required this.onSelectedFriend, 
  });

  final List<Friend> friends;
  //final void Function(BuildContext context, Friend friend) onSelectedFriend;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends!', 
          style: const TextStyle(fontSize: 30),
          ),
        ),
      body: 

    ListView.builder(
      itemCount: friends.length,
      itemBuilder: (ctx, index) => Padding(
        padding:
            EdgeInsets.fromLTRB(16, 16, 16, index == friends.length - 1 ? 16 : 0),
        child: FriendItem(
          friend: friends[index],
          onSelectFriend: (context, friend) {
            
          },
        ),
      ),
    ),
    );
    
  }
}