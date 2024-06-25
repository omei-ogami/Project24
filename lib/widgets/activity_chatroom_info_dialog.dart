import 'package:flutter/material.dart';
import 'package:project_24/main.dart';
import 'package:project_24/models/activity.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:provider/provider.dart';
import 'package:project_24/services/navigation.dart';
import 'package:project_24/models/user.dart' as models;
import 'package:project_24/repositories/user_repo.dart';
import 'package:project_24/view_models/me_vm.dart';

class ActivityChatroomInfoDialog extends StatelessWidget {
  const ActivityChatroomInfoDialog({
    super.key,
    
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {

    final ActivityViewmodel = Provider.of<ActivityViewModel>(context, listen: false);
    final activity = ActivityViewmodel.activities
        .firstWhere((activityItem) => activityItem.id == id);

    void _quit(BuildContext context) async {
      final MeViewmodel = Provider.of<MeViewModel>(context, listen: false);
      await MeViewmodel.quitJoinedActivity(id);
      await ActivityViewmodel.removeAttendance(id, MeViewmodel.myId);
      final nav = Provider.of<NavigationService>(context, listen: false);
      nav.quitChatroomToActivity();
    }

    bool isFull = (activity.people >= activity.capacity);
    bool isSingle = activity.people == 1;

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
                        (isFull)? '    ${activity.people}/${activity.capacity} (FULL)' : '    ${activity.people}/${activity.capacity}',
                        style: TextStyle(fontSize: 20, color: (isFull)? Colors.red : Colors.black),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          isSingle? null : _quit(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Text(' Quit ',
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
