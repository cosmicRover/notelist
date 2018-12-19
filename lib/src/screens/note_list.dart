import 'package:flutter/material.dart';
import 'package:notelist/src/screens/note_detail.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  int count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
        ),
        body: getNoteListView(),
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add),//FAB
                onPressed: (){
                  navigateToDetail('Add Note');
                }
            ));
  }

  //func that returns a ListView.builder with cards and listTile in it
  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.arrow_right),
              backgroundColor: Colors.yellow,
            ),
            title: Text("Hellooooo"),
            trailing: Icon(Icons.delete),
            onTap: (){
              navigateToDetail('Edit Note');
            },
          ),
        );
      },
    );
  }

  //func to navigate to NoteDetail screen
  //string title will be passed to the page as a constructor param
  void navigateToDetail(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetail(title);
    }));
  }
}
