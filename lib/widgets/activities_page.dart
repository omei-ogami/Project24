import 'package:flutter/material.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:project_24/models/activity.dart';
import 'activities.dart';
import 'package:project_24/services/navigation.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  void _selectActivity(BuildContext context, Activity activity) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goActivityInfoOnCategory(categoryId: categoryId, activityId: activity.activityId);
  }

  @override
  Widget build(BuildContext context) {
    final category = initialCategories[categoryId]!;
    List<Activity> allActivity = Provider.of<List<Activity>>(context);
    final activitiesShown = allActivity
      .where((item) => item.category.contains(category.title)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title, style: const TextStyle(fontSize: 30),),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final nav = Provider.of<NavigationService>(context, listen: false);
              //final viewModel = Provider.of<>(context, listen: false);
              nav.goCreateActivity();
            }
          ),
        ],
      ),
      body: Activities(
        activities: activitiesShown,
        onSelectedActivity: _selectActivity,
      ),
    );
  }
}