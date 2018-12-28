

class Note{
  int _id, _priority;
  String _title, _description, _date;

  //regular constructor. _priority is optional
  Note(this._title, this._description, this._date, [this._priority]);

  //named constructor that accepts ID
  Note.withId(this._id, this._title, this._description, this._date, [this._priority]);

  //getters
  int get id => _id;
  int get priority => _priority;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  //setters
  set title(String newTitle){
    if (newTitle.length>1){
      this._title = newTitle;
    }
  }

  set description(String newDescription){
    if (newDescription.length>1){
      this._title = newDescription;
    }
  }

  set priority(int newPriority){
    if (newPriority >= 1 && newPriority <= 2){
      this._priority = newPriority;
    }
  }

  set date(String newDate){
    this._date = newDate;
  }

  //convert a note object to map object
  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    if(id != null){
      map['id'] = _id;
    }

    return map;
  }

  //extract a note object from map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }

}









































