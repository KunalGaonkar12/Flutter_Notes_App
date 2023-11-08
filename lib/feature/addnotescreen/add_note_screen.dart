import 'package:flutter/material.dart';
import 'package:models/note/note.dart';
import 'package:notesapp/feature/addnotescreen/note_provider.dart';
import 'package:provider/provider.dart';


class AddNoteScreen extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  final String title;
   AddNoteScreen({Key? key, required this.isUpdate,this.note, this.title="Add a note"}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {


  final GlobalKey<FormState> _formFieldKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    var noteProv= Provider.of<NoteProvider>(context,listen: false);
    if(widget.isUpdate){
      noteProv.setData(widget.note!);
    }else{
      noteProv.init();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode noteFocus = FocusNode();
    NoteProvider noteProv= Provider.of<NoteProvider>(context);


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 27,
        elevation: 4,
        shadowColor: Color(0xff363434),
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: ()async {

            if(_formFieldKey1.currentState?.validate()==true){
              await  noteProv.addNote(isUpdate: widget.isUpdate);
                Navigator.pop(context);
            }
            }, icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child:
        Form(key: _formFieldKey1,child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: (value){
                if(value==""){
                  return "Please enter title";
                }else{
                  return null;
                }
              },
              controller: noteProv.titleController,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
              onFieldSubmitted: (value) {
                if (value != "") {
                  noteFocus.requestFocus();
                }
              },
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 30,color: Colors.white24,),
                  border: InputBorder.none),
              autofocus: widget.isUpdate?false:true,
            ),
            Expanded(
              child: TextFormField(
                controller: noteProv.contentController,
                focusNode: noteFocus,
                style: const TextStyle(fontSize: 20,color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Note",
                    hintStyle: TextStyle(fontSize: 20,color: Colors.white24),
                    border: InputBorder.none),
                maxLines: null,
              ),
            )
          ],
        ))

      ),
    );
  }
}
