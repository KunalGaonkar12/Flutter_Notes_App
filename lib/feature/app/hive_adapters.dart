import 'package:hive/hive.dart';
import 'package:models/note/note.dart';

class RegisterAdapters{

static void registerHiveAdapters (){
Hive.registerAdapter(NoteAdapter());
}
}