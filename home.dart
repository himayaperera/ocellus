import 'package:flutter/material.dart';

import 'openMap.dart';
import 'MyImagePicker.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor:Colors.indigo[900],

        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //SizedBox to increase the size of the buttons
                  SizedBox(
                    width: 400.0,
                    height: 200.0,
                  child: new ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.yellow;
                          return Colors.deepOrange; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      MapUtils.openMap(38.8977,77.0365);
                    },
                    child: new Text("NAVIGATE",
                        style: TextStyle(
                          fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  SizedBox(
                    width: 400.0,
                    height: 200.0,
                    child: new ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.yellow;
                            return Colors.purpleAccent; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/landingScreen');
                      },
                      child: new Text("SCAN OBJECT",
                          style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  SizedBox(
                    width: 400.0,
                    height: 200.0,
                    child: new ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.yellow;
                            return Colors.deepOrange; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/settings');
                      },
                      child: new Text("SETTINGS",
                        style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}