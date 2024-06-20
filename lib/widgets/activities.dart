import 'package:flutter/material.dart';
import 'package:project_24/models/activity.dart';
import 'activity_item.dart';

class Activities extends StatelessWidget {
  const Activities({
    super.key,
    required this.activities,
    required this.onSelectedActivity, 
  });

  final List<Activity> activities;
  final void Function(BuildContext context, Activity activity) onSelectedActivity;

  @override
  Widget build(BuildContext context) {
    if(activities.isEmpty){
      return Center(
        child: Text(
            'No activities to show here.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (ctx, index) => Padding(
        padding:
            EdgeInsets.fromLTRB(16, 16, 16, index == activities.length - 1 ? 16 : 0),
        child: ActivityItem(
          activity: activities[index],
          onSelectActivity: onSelectedActivity,
        ),
      ),
    );
  }
}