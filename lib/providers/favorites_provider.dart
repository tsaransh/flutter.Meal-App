import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/model/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);

  bool toggleFavoriteMealsStatus(Meal meal) {
    final isFavoitesMeal = state.contains(meal);
    if (isFavoitesMeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>((ref) {
  return FavoritesMealsNotifier();
});
