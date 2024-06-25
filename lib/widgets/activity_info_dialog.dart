import 'package:flutter/material.dart';
import 'package:project_24/main.dart';
import 'package:project_24/models/activity.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:provider/provider.dart';
import 'package:project_24/services/navigation.dart';
import 'package:project_24/models/user.dart' as models;
import 'package:project_24/repositories/user_repo.dart';
import 'package:project_24/view_models/me_vm.dart';

class ActivityInfoDialog extends StatelessWidget {
  const ActivityInfoDialog({
    super.key,
    required this.categoryId,
    required this.id,
  });

  final String id, categoryId;

  @override
  Widget build(BuildContext context) {
    void _decline() {
      final nav = Provider.of<NavigationService>(context, listen: false);
      nav.backActivitiesOnInfo();
    }

    void _join(BuildContext context) async {
      final _viewmodel = Provider.of<MeViewModel>(context, listen: false);
      await _viewmodel.addJoinedActivity(id);
      final nav = Provider.of<NavigationService>(context, listen: false);
      nav.goActivityChatroom(categoryId: categoryId, id: id);
    }

    final activity = Provider.of<ActivityViewModel>(context, listen: false)
        .activities
        .firstWhere((activityItem) => activityItem.id == id);

    return Scaffold(
        appBar: AppBar(
          title: Text(activity.title),
        ),
        body: Dialog.fullscreen(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(),
                    border: Border.all(color: Colors.black),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: const TextStyle(
                            fontSize: 30, decoration: TextDecoration.underline),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Intro :',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '    ${activity.intro}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Time :',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '    ${activity.time}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Location :',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '    ${activity.location}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Members :',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '    ${activity.people}/${activity.capacity}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (final tag in activity.tags)
                          Text(
                            '# $tag',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.indigo.shade400,
                                fontStyle: FontStyle.italic),
                          )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.teal.shade100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.organizer,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '    # ${activity.organizer}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          '    # ${activity.organizer}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          _join(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Text(' Join ',
                            style: TextStyle(
                                fontSize: 20, color: Colors.purple.shade700))),
                    OutlinedButton(
                        onPressed: _decline,
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            )),
                        child: Text('Decline',
                            style: TextStyle(
                                fontSize: 20, color: Colors.purple.shade700))),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
