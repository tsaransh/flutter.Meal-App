import 'package:flutter/material.dart';
import 'package:meal/data/dummy_data.dart';
import 'package:meal/model/category.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealScreen(title: category.title, meals: filteredMeals),
      ),
    );
    // Another way to do the above thing
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (ctx) => const MealScreen(title: 'some title', meals: [])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your category"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          // for (final category in availableCategories)
          //   CategoryGridItem(category: category)

          ...availableCategories
              .map((category) => CategoryGridItem(
                    category: category,
                    onSelectCategory: () => _selectCategory(context, category),
                  ))
              .toList()
        ],
      ),
    );
  }
}
