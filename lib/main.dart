import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/counter_page.dart';
import 'pages/theme_page.dart';
import 'pages/widhlist_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
          FutureProvider<List<Item>>(
            initialData: const [],
            create: (_) async => ItemProvider().loadUserData(),
          ),
          StreamProvider<int>(
            initialData: 0,
            create: (_) => EventProvider().intStream(),
          ),
          ChangeNotifierProvider<ThemeChangeProvider>.value(value: ThemeChangeProvider()),
        ],
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Provider Demo"),
              centerTitle: true,
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.home_outlined)),
                  Tab(icon: Icon(Icons.add)),
                  Tab(icon: Icon(Icons.message)),
                  Tab(icon: Icon(Icons.dark_mode_outlined)),
                ],
              ),
            ),
            body: const TabBarView(
              children: <Widget>[
                WishlistPage(),
                CounterPage(),
                MyEventPage(),
                ThemePage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Event page (counting)
class MyEventPage extends StatelessWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<int>(context);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('StreamProvider Example', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 50),
        Text(value.toString(), style: Theme.of(context).textTheme.headline4)
      ],
    ));
  }
}

// CountProvider (ChangeNotifier)
  class CountProvider extends ChangeNotifier {
    int _count = 0;
    int get counterValue => _count;

    void incrementCount() {
      _count++;
      notifyListeners();
    }

    void decrementCount() {
      _count--;
      notifyListeners();
    }
  }

// ItemProvider (Future)
class ItemProvider {
  final String _dataPath = "assets/items.json";
  List<Item> items = [];

  Future<String> loadAsset() async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<Item>> loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonItemData = jsonDecode(dataString);
    items = ItemList.fromJson(jsonItemData['items']).items;
    return items;
  }
}

// EventProvider (Stream)
class EventProvider {
  Stream<int> intStream() {
    Duration interval = const Duration(seconds: 2);
    return Stream<int>.periodic(interval, (int count) => count++);
  }
}

// Item Model
class Item {
  final String name, description, image;
  const Item(this.name, this.description, this.image);

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        image = json['image'];
}

// Item List Model
class ItemList {
  final List<Item> items;
  ItemList(this.items);

  ItemList.fromJson(List<dynamic> itemsJson)
      : items = itemsJson.map((user) => Item.fromJson(user)).toList();
}
