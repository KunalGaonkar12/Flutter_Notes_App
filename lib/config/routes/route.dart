import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:models/note/note.dart';
import 'package:notesapp/feature/addnotescreen/add_note_screen.dart';

import '../../feature/homescreen/home_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _cupertinoRoute(HomeScreen());

      case '/AddNote':
        final args = settings.arguments as AddNoteArgument;
        if (args.note == null) {
          return _cupertinoRoute(
              AddNoteScreen(isUpdate: args.isUpdate as bool));
        } else {
          return _cupertinoRoute(AddNoteScreen(
              isUpdate: args.isUpdate as bool,
              note: args.note as Note,
              title: args.name as String));
        }

      default:
        return _cupertinoRoute(HomeScreen());
    }
  }

  static Route<dynamic> _cupertinoRoute(Widget view) {
    return CupertinoPageRoute(builder: (_) => view);
  }
}

class AddNoteArgument {
  final String? name;
  final Note? note;
  final bool? isUpdate;

  AddNoteArgument({
    this.note,
    this.isUpdate,
    this.name,
  });
}
