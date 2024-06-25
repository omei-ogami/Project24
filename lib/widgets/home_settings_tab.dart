import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_24/models/category.dart';
import 'package:project_24/widgets/category_grid_item.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:project_24/models/user.dart';
import 'package:project_24/repositories/user_repo.dart';
import 'package:provider/provider.dart';
import '/services/navigation.dart';
import 'package:project_24/view_models/me_vm.dart';

class HomeSettingsTab extends StatelessWidget {
  const HomeSettingsTab({super.key});

  void _copyUserName(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User Name Copied!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String userAvatarUrl =
        Provider.of<MeViewModel>(context, listen: false).me!.avatarUrl;
    final String userUserName =
        Provider.of<MeViewModel>(context, listen: false).me!.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Settings', 
          style: const TextStyle(fontSize: 30),
          ),
        ),
      body: 
      Card(
        color: Colors.green.shade100,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: InkWell(
          //onTap: () => onSelectFriend(context, friend),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    userAvatarUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  userUserName,
                  style: const TextStyle(fontSize: 40),
                  overflow: TextOverflow.ellipsis,
                ),
                IconButton(
                  icon: const Icon(Icons.content_copy),
                  tooltip: 'Copy User Name',
                  onPressed: () {
                    _copyUserName(context, userUserName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
