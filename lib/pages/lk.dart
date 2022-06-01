import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/pages/favorites.dart';

class Lk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Lk();
}

class _Lk extends State<Lk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Профиль"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Favorites()));
                  },
                  child: Text("Понравившиеся"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Настройки"),
                )
              ],
            ),
          )),
    );
  }
}
