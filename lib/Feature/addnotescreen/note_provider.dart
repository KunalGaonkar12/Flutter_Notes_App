import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:notesapp/services/api_services.dart';
import 'package:uuid/uuid.dart';

import '../../services/connection_manager.dart';

class NoteProvider with ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Note tempNote=Note();
  List<Note> allNotes = [];
  String msg="";


  // NoteProvider() {
  //   fetchNotes("Kunal Gaonkar");
  // }

  List<String> colors=[
    "0xffE0754F","0xffF7D44C","0xff48D0E2","0xff4AD3B0"
  ];


  Future<String> fetchData()async {
    bool isConnected= await  ConnectionManager.isConnected() ;
    if(isConnected){
       print("Is connected");
       fetchNotes("Kunal Gaonkar");
       return "";
     }else{
       print("not connected");
       return "Please turn on internet";
     }
  }


  void init() async {
    titleController.clear();
    contentController.clear();
    msg=await fetchData();
    tempNote=Note();
  }

  Future<void> addNote({bool isUpdate=false}) async {
    Note newNote = Note();
    if(isUpdate){
      newNote=tempNote;
      newNote.title=titleController.text;
      newNote.content = contentController.text;
    }else{
      newNote.dateAdded = DateTime.now();
      newNote.id = const Uuid().v1();
      newNote.userId = "Kunal Gaonkar";
      newNote.title = titleController.text;
      newNote.content = contentController.text;
      // newNote.color=int.parse(colors[Random().nextInt(colors.length)]);
    }
    await saveNote(newNote);
    notifyListeners();
  }

  Future<void> fetchNotes(String id) async{
    allNotes= await ApiServices.fetchNote(id);
    notifyListeners();
  }



  Future<void> saveNote(Note newNote) async {
    int index = allNotes.indexWhere((element) => element.id == newNote.id);
    if (index > -1) {
      allNotes[index] = newNote;
    } else {
      allNotes.add(newNote);

    }
    notifyListeners();
    await ApiServices.addNote(newNote);
  }

  Future<void> deleteNote(String? id) async {
    int index = allNotes.indexWhere((element) => element.id == id);
    if (index > -1) {
      allNotes.removeAt(index);
      notifyListeners();
      await ApiServices.deleteNote(id);
    }

  }


  Future<void> setData(Note note) async {
    tempNote = note;
    titleController.text = note.title!;
    contentController.text = note.content!;
  }

}
