import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String _baseUrl = "http://10.0.2.2:5000/notes";



  static Future<void> addNote(Note note) async {
    try{
      Uri url = Uri.parse(_baseUrl+"/add");
      var response = await http.post(url, body: note.toJson());
      var deCoded= jsonDecode(response.body);

      if (kDebugMode) {
        print(deCoded.toString());
      }
    }catch(e){
      print(e.toString());
    }

  }

  static Future<void> deleteNote(String? id) async {
    Map<String?,dynamic> body;
    body={
      "id":id,
    };
    try{
      Uri url = Uri.parse(_baseUrl+"/delete");
      var response = await http.post(url, body:body);
      var deCoded= jsonDecode(response.body);

      if (kDebugMode) {
        print(deCoded.toString());
      }
    }catch(e){
      print(e.toString());
    }

  }

  static Future<List<Note>> fetchNote(String? id) async {
    Map<String?,dynamic> body;
    List<Note> notes=[];
    body={
      "userId":id,
    };
    try{
      Uri url = Uri.parse(_baseUrl+"/list");
      var response = await http.post(url,body: body);
      var deCoded= jsonDecode(response.body);
      
      for (var note in deCoded){
        Note data= Note.fromJson(note);
        notes.add(data);
      }

      if (kDebugMode) {
        print(deCoded.toString());
      }

      return notes;
    }catch(e){
      print(e.toString());
    }
    return [];
  }
}
