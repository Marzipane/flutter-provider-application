import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Consumer<List<Item>>(
          builder: (context, List<Item> items, _) {
            return Expanded(
              child: items.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(0),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                            // color: Colors.grey,
                            margin: const EdgeInsets.only(
                                left: 35, right: 35, top: 20),
                            height: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.5), // red as border color
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '${items[index].name} ',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    '${items[index].description}  ',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      'assets/images/download.jpg',
                                      height: 200.0,
                                      width: 200.0,
                                    ),
                                  )
                                ],
                              ),
                            ));
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}
