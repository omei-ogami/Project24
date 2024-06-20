import 'package:flutter/material.dart';
import 'package:project_24/models/category.dart';
import 'package:project_24/widgets/category_grid_item.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:provider/provider.dart';
import '/services/navigation.dart';

class HomeCategoriesTab extends StatelessWidget {
  const HomeCategoriesTab({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goActivitiesOnCategory(categoryId: category.id);
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [
          for(final category in initialCategories.values)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}