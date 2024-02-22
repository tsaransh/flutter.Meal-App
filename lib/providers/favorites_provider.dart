import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/model/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);

  void toggleFavoriteMealsStatus(Meal meal) {
    if (state.contains(meal)) {
      state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>((ref) {
  return FavoritesMealsNotifier();
});
