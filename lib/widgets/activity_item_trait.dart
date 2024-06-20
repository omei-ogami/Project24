import 'package:flutter/material.dart';
import 'package:project_24/models/activity.dart';

class ActivityItemTrait extends StatelessWidget {
  const ActivityItemTrait({
    super.key,
    required this.activity,
    
  });

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('#${activity.tags[0]}', style: const TextStyle(color: Colors.indigo, fontStyle: FontStyle.italic, fontSize: 20),),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Text('${activity.people}/${activity.capacity} ', style: const TextStyle(fontSize: 20),),
              const Icon(Icons.people_alt),
            ],
          )
        ),
      ],
    );
  }
}