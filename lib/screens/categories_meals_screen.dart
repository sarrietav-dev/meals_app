import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> meals;

  const CategoryMealsScreen({Key key, this.meals}) : super(key: key);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _title;
  List<Meal> _categoryMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      _title = routeArgs["title"];
      _categoryMeals = widget.meals
          .where((element) => element.categories.contains(routeArgs["id"]))
          .toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void handleRemoveMeal(Meal meal) => setState(() {
        _categoryMeals.removeWhere((element) => meal == element);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          key: ValueKey(_categoryMeals[index].id),
          meal: _categoryMeals[index],
        ),
        itemCount: _categoryMeals.length,
      ),
    );
  }
}
