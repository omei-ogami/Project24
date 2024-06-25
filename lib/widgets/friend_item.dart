import 'package:flutter/material.dart';
import 'package:project_24/models/friend.dart';
import 'activity_item_trait.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({
    super.key,
    required this.friend,
    required this.onSelectFriend,
  });

  final Friend friend;
  final void Function(BuildContext context, Friend friend) onSelectFriend;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade100,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => onSelectFriend(context, friend),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  friend.avatarUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Text(friend.userName, style: const TextStyle(fontSize: 40), overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 5,),
              //Text(activity.location, style: const TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}