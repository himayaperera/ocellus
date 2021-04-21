import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'settings.dart';
import 'signup.dart';
import 'home.dart';
import 'MyImagePicker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        '/signup':(BuildContext context)=> new SignupPage(),
        '/home':(BuildContext context) =>new HomePage(),
        '/settings':(BuildContext context) =>new SettingsPage(),
        '/landingScreen':(BuildContext context) =>new MyImagePicker()
      },

      home:new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState()=> new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build (BuildContext context){
    return new Scaffold(
      backgroundColor:Colors.indigo[900],
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text('OCELLUS',
              style: TextStyle(
                fontSize: 80.0,fontWeight: FontWeight.bold,color: Colors.deepOrange),
            ),
          ),
          SizedBox(height: 50.0,),
          Container(padding: EdgeInsets.only(top: 35.0,left: 20.0,right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'USER NAME',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)
                    )
                  ),
                ),
                SizedBox(height: 50.0,),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)
                      )
                  ),
                  obscureText: true,
                ),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0,left:20.0),
                  child: InkWell(
                    child:Text('Forgot Password',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.deepOrangeAccent,
                    elevation: 7.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.yellow;
                            return Colors.deepOrange; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).pushNamed('/home');
                      },
                      child: Center(
                        child: Text('SIGN IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to Ocellus ?',
                style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('/signup');
                },
                child: Text('Sign up',
                  style:TextStyle(color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}





