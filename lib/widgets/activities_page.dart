import 'package:flutter/material.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:project_24/models/activity.dart';
import 'activities.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:project_24/services/navigation.dart';
import 'package:provider/provider.dart';
import 'package:project_24/view_models/me_vm.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  void _selectActivity(BuildContext context, Activity activity) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goActivityInfoOnCategory(categoryId: categoryId, id: activity.id!);
  }

  @override
  Widget build(BuildContext context) {
    final category = initialCategories[categoryId]!;
    ActivityViewModel allActivity = Provider.of<ActivityViewModel>(context);
    final activitiesShown = allActivity.activities
      .where((item) => item.category.contains(category.id))
      .toList();

    final _viewmodel = Provider.of<MeViewModel>(context, listen: false);
    activitiesShown.removeWhere((item) => _viewmodel.me!.joinedActivities.contains(item.id),);
    print(activitiesShown);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title, style: const TextStyle(fontSize: 30),),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_return),
            onPressed: () {
              final nav =
                Provider.of<NavigationService>(context, listen: false);
              final viewModel =
                Provider.of<ActivityViewModel>(context, listen: false);
              nav.backActivitiesOnInfo();
            }
          ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final nav = Provider.of<NavigationService>(context, listen: false);
              final viewModel = Provider.of<ActivityViewModel>(context, listen: false);
              nav.goCreateActivity(categoryId: categoryId);
            }
          ),
        ],
      ),
      body: Consumer<ActivityViewModel>(
        builder: (context, viewModel, _) {
          // print(viewModel.activities);
          return Activities(activities: activitiesShown, onSelectedActivity: _selectActivity);
        },
      )
    );
  }
}