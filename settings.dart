import 'package:flutter/material.dart';
import 'globals.dart' as globals;



class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool valuefirst = false;
  bool valuesecond = false;
  bool valuethird = false;
  bool valuefourth = false;
  List<bool> isSelected;
  int fontSize=17;
  int getFontSize(int index){
    if(index==0){
      return 14;
    } else if(index==1){
      return 20;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isSelected=[
      false,
      true
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:Colors.indigo[900],
        body: Container(
            padding: new EdgeInsets.all(22.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Filters',
                  style: TextStyle(fontSize: fontSize*1.0),
                ),
                ToggleButtons(
                  color:Colors.green,
                  children: [
                    Text('A',style: TextStyle(fontSize: 14),),
                    Text('A',style: TextStyle(fontSize: 20),),
                  ],isSelected: isSelected,
                  onPressed: (index){
                    for(var i=0;i<isSelected.length;i++){
                      if(i==index){
                        isSelected[i]=true;
                      }else{
                        isSelected[i]=false;
                      }
                    }
                    fontSize=getFontSize(index);
                    setState(() {

                    });
                  },
                ),
                Container(
                  color: Colors.deepOrange,
                  child: Column(
                      children: <Widget>[
                        Text(
                          'Navigation',
                          style: TextStyle(fontSize: fontSize*1.0),
                        ),
                        CheckboxListTile(
                          secondary: const Icon(Icons.circle),
                          title:  Text('Item Description',style: TextStyle(fontSize: fontSize*1.0)),
                          value: this.valuefirst,
                          onChanged: (bool value) {
                            setState(() {
                              this.valuefirst = value;
                            });
                          },
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          secondary: const Icon(Icons.circle),
                          title:  Text('Item Color',style: TextStyle(fontSize: fontSize*1.0),),
                          value: this.valuesecond,
                          onChanged: (bool value) {
                            setState(() {
                              this.valuesecond = value;
                            });
                          },
                        ),
                        Text(
                          'Scan Object',style: TextStyle(fontSize: fontSize*1.0),
                        ),
                        CheckboxListTile(
                          secondary: const Icon(Icons.circle),
                          title:  Text('Item Description',style: TextStyle(fontSize: fontSize*1.0)),
                          value: this.valuethird,
                          onChanged: (bool value) {
                            setState(() {
                              this.valuethird = value;
                            });
                          },
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          secondary: const Icon(Icons.circle),
                          title:  Text('Item Color',style: TextStyle(fontSize: fontSize*1.0)),
                          value: this.valuefourth,
                          onChanged: (bool value) {
                            setState(() {
                              this.valuefourth = value;
                            });
                          },
                        ),
                      ]
                  ),
                ),


                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.home),
                  label: Text('HOME'),
                  tooltip: 'Click to Exit',
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  focusColor: Colors.red,
                  hoverColor: Colors.white,
                  elevation: 6,
                  hoverElevation: 20,
                  splashColor: Colors.blueGrey,
                  highlightElevation: 20,
                ),
              ],
            ),),
      ),
    );
  }
}