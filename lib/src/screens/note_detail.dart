import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notelist/models/note.dart';
import 'package:notelist/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  //constructor takes one string var
  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    //returning appBartTitle to the NoteDetailState class
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  String appBarTitle;
  Note note;

  //vars for the dropDownMenu items
  static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  //NoteDetailState ultimately receives the appBarTitle passed from prev page to here
  NoteDetailState(this.note, this.appBarTitle);

  //two text edit controllers to let user edit input box
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;

    //wrapping the scaffold with WillPopScope() lets us control what happens
    //when the user presses the back button using onWillPop()
    return WillPopScope(
      onWillPop: () {
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
                    }).toList(), //laid out as a list of items
                    style: textStyle,
                    value: getPriorityAsString(note.priority), //default value to Low
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                        updatePriorityAsInt(valueSelectedByUser);
                      });
                    }),
              ),

              // Title input
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('Something changed in Title Text Field');
                    updateTitle();
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
                    updateDescription();
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
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked");
                            _save();
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                            _delete();
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

  //convert string priority to int before saving to database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  //convert int priority to String before saving to database
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  //update the title of note object
  void updateTitle() {
    note.title = titleController.text;
  }

  //update the description of note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  //func to save the note
  void _save() async {
    Navigator.pop(context, true);//takes back

    //setting the date using the intl.dart package
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;

    if (note.id != null) {
      result = await helper.updateNote(note);//if id exits, it's an update op
    } else {
      result = await helper.insertNote(note);//if no id, insert note into array
    }

    //showing a dialogue box based on the response var
    result != 0
        ? _showAlertDialog('Status', "Note deleted")
        : _showAlertDialog('Status', "Error occoured");
  }

  //func to delete node
  void _delete() async {

    Navigator.pop(context, true);

    if (note.id == null) {
      _showAlertDialog("Status", "No note deleted");
    }

    //deletes the actual note if note id exits
    int result = await helper.deleteNote(note.id);

    //showing a dialogue box based on the response var
    result != 0
        ? _showAlertDialog('Status', "Note deleted")
        : _showAlertDialog('Status', "Error occoured");
  }

  //simple dialogue box window
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
