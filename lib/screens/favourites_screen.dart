import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  const FavouritesScreen({Key key, this.favouriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty)
      return Center(
        child: Text("There are not favourites!"),
      );
    else
      return ListView.builder(
        itemBuilder: (context, index) => MealItem(
          key: ValueKey(favouriteMeals[index].id),
          meal: favouriteMeals[index],
        ),
        itemCount: favouriteMeals.length,
      );
  }
}
