import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.availableMeals, super.key});

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final mealsUnderCategory =
        availableMeals.where(((meal) => meal.categories.contains(category.id))).toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              meals: mealsUnderCategory,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
