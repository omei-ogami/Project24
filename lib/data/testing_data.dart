import 'package:flutter/material.dart';
import 'package:project_24/models/activity.dart';
import 'package:project_24/models/category.dart';
import 'package:project_24/models/user.dart';

// Users are not be able to add categories
const initialCategories = {
  'c1': Category(id: 'c1', title: 'Music', icon: Icons.music_note_rounded),
  'c2': Category(id: 'c2', title: 'Game', icon: Icons.gamepad),
  'c3': Category(id: 'c3', title: 'Sport', icon: Icons.sports_basketball),
  'c4': Category(id: 'c4', title: 'Food', icon: Icons.fastfood),
  'c5': Category(id: 'c5', title: 'Movie', icon: Icons.movie),
  'c6': Category(id: 'c6', title: 'Travel', icon: Icons.airplane_ticket),
};

// For UI testing
User user1 = User(name: 'Davit', phone: '0000-0000', email: 'davit@email.com');
User user2 = User(name: 'Hsu Yu-Hao', phone: '0905-114-514', email: '810659@omi.com');

// For UI testing
var testActivity = [
  Activity(
    activityId: 'Music-1', 
    category: 'Music', 
    title: 'Concert', 
    location: 'Airport, Japan', 
    time: '7/31/2024, 7:00 PM - 7:00 AM',
    tags: ['Japanese', 'Fresh', 'Pop-up'], 
    intro: 'Personally, the concert means a lot to me. To sum up, after the above discussion, the meaning of the concert is actually hidden in our lives, why does the concert happen?', 
    capacity: 6, 
    people: 2, 
    organizer: 'user1', 
    attendance: ['user1', 'user2'],
  ),
  Activity(
    activityId: 'Game-1', 
    category: 'Game', 
    title: 'Software Design', 
    location: 'Jail, nthu', 
    time: 'forever',
    tags: ['I want to sleep', 'please'], 
    intro: 'Kill me', 
    capacity: 100, 
    people: 1, 
    organizer: 'user2', 
    attendance: ['user2'],
  ),
  Activity(
    activityId: 'Game-2', 
    category: 'Game', 
    title: '1d', 
    location: 'Right', 
    time: '113/2/30',
    tags: ['gorilla', 'ddlm'], 
    intro: 'I had recently worked on developing a nested navigation feature with a persistent bottom navigation bar using go_router and it’s new feature ShellRoute and it works like a charm.', 
    capacity: 9, 
    people: 2, 
    organizer: 'user1', 
    attendance: ['user1', 'user2'],
  ),
];