import 'package:flutter/material.dart';
import 'package:notelist/src/screens/note_detail.dart';
import 'package:notelist/src/screens/note_list.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purple,
      ),
      title: "NoteList",
      home: NoteList(),
    );
  }
}
