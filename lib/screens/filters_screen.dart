import 'package:flutter/material.dart';
import 'package:meals_app/screens/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function onFilterSave;

  const FiltersScreen({Key key, this.onFilterSave}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _gluttenFree = false;

  bool _lactoseFree = false;

  bool _vegetarian = false;

  bool _vegan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluttenFree': _gluttenFree,
                  'lactoseFree': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.onFilterSave(selectedFilters);
                Navigator.of(context).pushReplacementNamed('/');
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              SwitchListTile(
                value: _gluttenFree,
                onChanged: (value) {
                  setState(() {
                    _gluttenFree = value;
                  });
                },
                title: const Text("Glutten Free"),
                subtitle: const Text("Only include glutter-free meals"),
              ),
              SwitchListTile(
                value: _lactoseFree,
                onChanged: (value) {
                  setState(() {
                    _lactoseFree = value;
                  });
                },
                title: const Text("Lactose-Free"),
                subtitle: const Text("Only include lactose-free meals"),
              ),
              SwitchListTile(
                value: _vegetarian,
                onChanged: (value) {
                  setState(() {
                    _vegetarian = value;
                  });
                },
                title: const Text("Vegetarian"),
                subtitle: const Text("Only include vegetarian meals"),
              ),
              SwitchListTile(
                value: _vegan,
                onChanged: (value) {
                  setState(() {
                    _vegan = value;
                  });
                },
                title: const Text("Vegan"),
                subtitle: const Text("Only include vegan meals"),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
