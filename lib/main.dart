import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'package:meals_app/widgets/dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];
  Map<String, bool> _filters = {
    'gluttenFree': false,
    'lactoseFree': false,
    'vegetarian': false,
    'vegan': false,
  };

  void handleFiltersSave(Map<String, bool> filters) {
    setState(() {
      _filters = filters;
      availableMeals =
          DUMMY_MEALS.where((element) => filterMeal(element)).toList();
    });
  }

  bool filterMeal(Meal meal) {
    bool filterResult = true;
    if (_filters["gluttenFree"])
      filterResult = filterResult == meal.isGlutenFree;
    if (_filters["lactoseFree"])
      filterResult = filterResult == meal.isLactoseFree;
    if (_filters["vegetarian"])
      filterResult = filterResult == meal.isVegetarian;
    if (_filters["vegan"]) filterResult = filterResult == meal.isVegan;
    return filterResult;
  }

  void _toggleFavourite(Meal meal) {
    if (favouriteMeals.contains(meal))
      setState(() {
        favouriteMeals.remove(meal);
      });
    else
      setState(() {
        favouriteMeals.add(meal);
      });
  }

  bool _isMealFavourite(Meal meal) {
    return favouriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                    fontFamily: "RobotoCondensed",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
      routes: {
        '/': (context) => TabsScreen(
              favouriteMeals: favouriteMeals,
            ),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              meals: availableMeals,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              onPressedFAB: _toggleFavourite,
              isMealFavourite: _isMealFavourite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
              onFilterSave: handleFiltersSave,
            ),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals App"),
      ),
    );
  }
}
