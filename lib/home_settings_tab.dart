import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_24/models/category.dart';
import 'package:project_24/widgets/category_grid_item.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:provider/provider.dart';
import '/services/navigation.dart';

class HomeSettingsTab extends StatelessWidget {
  const HomeSettingsTab({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goActivitiesOnCategory(categoryId: category.id);
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcEPafH7OSswGihwHkmI7auTA8cq8lbKnkBg&s'),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('UserName'),
                  IconButton(
                    icon: const Icon(Icons.content_copy),
                    tooltip: 'Copy User Name',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: 'UserName')); 
                    }
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit User Name',
                    onPressed: () {
                      
                    }
                  )
                ],
              ),
              
              Text('tst')
            ],
          )
        ],
      ),
    );
  }
}