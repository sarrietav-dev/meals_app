import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favourites_screen.dart';
import 'package:meals_app/screens/main_drawer.dart';

class TabsScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  const TabsScreen({Key key, this.favouriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meals"),
        ),
        drawer: MainDrawer(),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.category),
              text: "Categories",
            ),
            Tab(
              icon: Icon(Icons.star),
              text: "Favourites",
            )
          ]),
        ),
        body: TabBarView(children: [
          CategoriesScreen(),
          FavouritesScreen(
            favouriteMeals: favouriteMeals,
          )
        ]),
      ),
    );
  }
}
