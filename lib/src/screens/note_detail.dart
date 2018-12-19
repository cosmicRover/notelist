import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;

  //constructor takes one string var
  NoteDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    //returning appBartTitle to the NoteDetailState class
    return NoteDetailState(this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  final String appBarTitle;

  //vars for the dropDownMenu items
  static var _priorities = ['High', 'Low'];

  //NoteDetailState ultimately receives the appBarTitle passed from prev page to here
  NoteDetailState(this.appBarTitle);

  //two text edit controllers to let user edit input box
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    //wrapping the scaffold with WillPopScope() lets us control what happens
    //when the user presses the back button using onWillPop()
    return WillPopScope(

      onWillPop: (){
        //get's executed when user presses back button
        print("back button pressed!");
        Navigator.pop(context);
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text('$appBarTitle'),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // First element
              ListTile(
                //title is a dropDownButton
                title: DropdownButton(
                  //items take _priorities and maps them to dropDownStringItem
                  //of String type
                    items: _priorities.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        //value is dropDownStringItem and so is text
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),//laid out as a list of items
                    style: textStyle,
                    value: 'Low',//default value to Low
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                      });
                    }),
              ),

              // Title inout
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('Something changed in Title Text Field');
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              // Description input
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('Something changed in Description Text Field');
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              // Row of buttons
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked");
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
