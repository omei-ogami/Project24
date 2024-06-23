import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_24/models/activity.dart';
import 'package:project_24/repositories/activity_item_repo.dart';

class ActivityViewModel with ChangeNotifier {
  final ActivityItemRepo _activityItemRepo;
  StreamSubscription<List<Activity>>? _itemsSubscription;
  List<Activity> _activities = [];
  List<Activity> get activities => _activities; // Private field to store activities

  // Constructor with an optional parameter for injecting the repository
  ActivityViewModel({ActivityItemRepo? activityItemRepo})
      : _activityItemRepo = activityItemRepo ?? ActivityItemRepo() {
    // Subscribe to the stream of activities
    _itemsSubscription = _activityItemRepo.streamActivity().listen(
      (items) {
        _activities = items;
        notifyListeners(); // Notify listeners about the change
      }, 
    );
  }
  
  //

  // Method to add a new activity
  Future<void> addActivity(Activity activity) async {
    await _activityItemRepo.addItem(activity);
  }
}