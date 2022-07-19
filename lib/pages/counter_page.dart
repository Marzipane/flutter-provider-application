import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountProvider state = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ChangeNotifierProvider Example',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 50),
            Text('${state.counterValue}',
                style: Theme.of(context).textTheme.headline4),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => state.decrementCount(),
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.green,
                      onPressed: () => value.incrementCount(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}