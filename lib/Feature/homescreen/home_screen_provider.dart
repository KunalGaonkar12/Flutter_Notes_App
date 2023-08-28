import 'package:flutter/cupertino.dart';

import '../../models/note_model.dart';

class HomeScreenProvider extends ChangeNotifier{

  Note? note;
  List<Note>? allNotes;


  init(){
    note=Note();
     allNotes=[];
  }


  void fetchNotes(){
  }




}