import 'package:flutter/material.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:project_24/models/activity.dart';
import 'activities.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:project_24/services/navigation.dart';
import 'package:provider/provider.dart';
import 'package:project_24/view_models/me_vm.dart';

class HomeChatroomTab extends StatelessWidget {
  const HomeChatroomTab({
    super.key,
  });

  void _selectActivity(BuildContext context, Activity activity) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goActivityChatroom(id: activity.id!);
  }

  @override
  Widget build(BuildContext context) {
    ActivityViewModel allActivity = Provider.of<ActivityViewModel>(context);
    final _viewmodel = Provider.of<MeViewModel>(context, listen: false);
    final activitiesShown = allActivity.activities
      .where((item) => _viewmodel.me!.joinedActivities.contains(item.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Activities', style: TextStyle(fontSize: 30),),
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