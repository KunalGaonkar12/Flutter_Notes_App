
import 'package:interfaces/i_db_helper.dart';
import 'package:models/note/note.dart';


class NoteRepository with IDBHelper {

  Future<List<Note>> fetchNotes(String boxName) async {
    List<Note> notes = await fetchData<Note>(boxName);
    return notes;
  }

  Future<void> createNote(Note note,String boxName)async{
    await saveData<Note>(note,boxName);
  }

  Future<void> editNote(int index,Note note,String boxName)async{
    await updateData<Note>(index,note,boxName);
  }

  Future<void> deleteNote(int index,String boxName)async{
    await deleteData<Note>(index,boxName);
  }


}