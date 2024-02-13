import 'package:flutter/material.dart';
import 'package:meal/model/meal.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/filters.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabState();
  }
}

class _TabState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];

  void _showSnakBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toogleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      _showSnakBar('Meal is no longer a favorite');
    } else {
      setState(() {
        _favoriteMeal.add(meal);
      });
      _showSnakBar('Meaked as favorite');
    }
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    if (identifier == 'filters') {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toogleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: _favoriteMeal,
        onToggleFavorite: _toogleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
