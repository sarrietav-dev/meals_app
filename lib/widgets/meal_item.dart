import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({@required key, @required this.meal}) : super(key: key);

  void handleTap(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailScreen.routeName,
        arguments: {"currentMeal": meal}).then((value) {});
  }

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return "Simple";
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Pricey:
        return "Pricey";
      case Affordability.Luxurious:
        return "Luxurious";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleTap(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Column(
          children: [
            Stack(
              children: [
                _MealItemImage(meal: meal),
                _MealItemTitle(meal: meal),
              ],
            ),
            _MealItemDetails(
                meal: meal,
                complexityText: complexityText,
                affordabilityText: affordabilityText)
          ],
        ),
      ),
    );
  }
}

class _MealItemImage extends StatelessWidget {
  const _MealItemImage({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Image.network(
        meal.imageUrl,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MealItemTitle extends StatelessWidget {
  const _MealItemTitle({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 10,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.black54),
        width: 320,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Text(
          meal.title,
          style: TextStyle(fontSize: 26, color: Colors.white),
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}

class _MealItemDetails extends StatelessWidget {
  const _MealItemDetails({
    Key key,
    @required this.meal,
    @required this.complexityText,
    @required this.affordabilityText,
  }) : super(key: key);

  final Meal meal;
  final String complexityText;
  final String affordabilityText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _MealItemInfo(
              icon: Icons.schedule,
              text: "${meal.duration} min",
            ),
            _MealItemInfo(icon: Icons.work, text: complexityText),
            _MealItemInfo(icon: Icons.attach_money, text: affordabilityText)
          ],
        ));
  }
}

class _MealItemInfo extends StatelessWidget {
  const _MealItemInfo({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 6,
        ),
        Text(text),
      ],
    );
  }
}
