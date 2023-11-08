import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:models/hive_helper.dart';
import 'package:models/note/note.dart';
import 'package:repositories/repositories.dart';
import 'package:uuid/uuid.dart';


class NoteProvider with ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  bool validate = false;

  Note tempNote=Note();
  List<Note?> allNotes = [];

  List<String> colors=[
    "0xffE0754F","0xffDF5970","0xffF59138","0xff3E9399","0xff71B578","0xffF7D44C","0xff48D0E2","0xff4AD3B0","0xff238ft6","0xff23AFD6"
  ];


  Future<void> fetchData()async {
    allNotes=
    await NoteRepository().fetchNotes(BoxName.note);
    notifyListeners();
  }


  void init() async {
    titleController.clear();
    contentController.clear();
    await fetchData();
    tempNote=Note();
  }

  Future<void> addNote({bool isUpdate=false}) async {
    Note newNote = Note();
    if(isUpdate){
      newNote=tempNote;
      newNote.title=titleController.text;
      newNote.content = contentController.text;
      await saveNote(newNote);
    }else{
      newNote.dateAdded = DateTime.now();
      newNote.id = const Uuid().v1();
      newNote.userId = "Kunal Gaonkar";
      newNote.title = titleController.text;
      newNote.content = contentController.text;
      newNote.color=int.parse(colors[Random().nextInt(colors.length)]);
      // final Random random = Random();
      // print(random.nextInt(0xffffff));
      // newNote.color=(random.nextInt(0xffffff));
      await saveNote(newNote);

    }

    notifyListeners();
  }


  Future<void> saveNote(Note newNote) async {
    int index = allNotes.indexWhere((element) => element?.id == newNote.id);
    if (index > -1) {
      // allNotes[index] = newNote;
      await NoteRepository().editNote(index,newNote,BoxName.note);
    } else {
      // allNotes.add(newNote);
      await NoteRepository().createNote(newNote, BoxName.note);
    }
    await fetchData();
    notifyListeners();

  }

  Future<void> deleteNote(String? id) async {
    int index = allNotes.indexWhere((element) => element?.id == id);
    if (index > -1) {
      await NoteRepository().deleteNote(index, BoxName.note);
      await fetchData();
    }
    notifyListeners();
  }


  Future<void> setData(Note note) async {
    tempNote = note;
    titleController.text = note.title!;
    contentController.text = note.content!;
  }

}
