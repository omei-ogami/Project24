import 'package:flutter/material.dart';
import 'package:project_24/models/activity.dart';
import 'activity_item_trait.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.activity,
    required this.onSelectActivity,
  });

  final Activity activity;
  final void Function(BuildContext context, Activity activity) onSelectActivity;

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
        onTap: () => onSelectActivity(context, activity),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.title, style: const TextStyle(fontSize: 40), overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 5,),
              //Text(activity.location, style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 5,),
              ActivityItemTrait(activity: activity)
            ],
          ),
        ),
      ),
    );
  }
}