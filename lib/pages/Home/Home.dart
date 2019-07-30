import 'package:flutter/material.dart';
import '../Clock/Clock.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter组件练习'),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            Container(
              child: Text('banner'),
              color: Colors.red,
              width: double.infinity,
              height: 100.0,
            ),
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 10.0,
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (contxt) => Clock()),
                      );
                    },
                    child: Text('闹钟'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
