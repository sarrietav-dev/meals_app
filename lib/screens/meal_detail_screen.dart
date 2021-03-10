import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/name-detail";
  final Function onPressedFAB;
  final Function isMealFavourite;

  const MealDetailScreen({Key key, this.onPressedFAB, this.isMealFavourite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Meal meal = (ModalRoute.of(context).settings.arguments
        as Map<String, Meal>)["currentMeal"];

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => onPressedFAB(meal),
            child:
                Icon(isMealFavourite(meal) ? Icons.star : Icons.star_border)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _MealDetailImage(meal: meal),
              _MealDetailTitle(
                title: "Ingredients",
              ),
              _IngredientList(
                meal: meal,
              ),
              _MealDetailTitle(
                title: "Steps",
              ),
              _StepsList(
                meal: meal,
              ),
            ],
          ),
        ));
  }
}

class _MealDetailImage extends StatelessWidget {
  const _MealDetailImage({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Image.network(
        meal.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MealDetailTitle extends StatelessWidget {
  final String title;

  const _MealDetailTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

class _IngredientList extends StatelessWidget {
  const _IngredientList({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return _MealDetailListWrapper(
      ListView.builder(
        itemBuilder: (context, index) => Card(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(meal.ingredients[index]),
          ),
        ),
        itemCount: meal.ingredients.length,
      ),
    );
  }
}

class _StepsList extends StatelessWidget {
  const _StepsList({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return _MealDetailListWrapper(ListView.builder(
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text(
              meal.steps[index],
            ),
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
      itemCount: meal.steps.length,
    ));
  }
}

class _MealDetailListWrapper extends StatelessWidget {
  final Widget child;

  const _MealDetailListWrapper(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 300,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: child);
  }
}
