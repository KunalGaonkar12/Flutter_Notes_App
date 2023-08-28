import 'package:flutter/material.dart';
import 'package:notesapp/Feature/addnotescreen/note_provider.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:provider/provider.dart';


class AddNoteScreen extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNoteScreen({Key? key, required this.isUpdate,this.note}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

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
        title: const Text("Add New Note"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: ()async {
           await  noteProv.addNote(isUpdate: widget.isUpdate);
         Navigator.pop(context);

         }, icon: const Icon(Icons.check))
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.blue,
      //   notchMargin: 10,
      //   child: IconTheme(
      //     data: const IconThemeData(color: Colors.white, size: 36),
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
      //           const SizedBox(
      //             width: 10,
      //           ),
      //           IconButton(
      //               onPressed: () {}, icon: const Icon(Icons.check)),
      //           const SizedBox(
      //             width: 10,
      //           ),
      //           IconButton(onPressed: () {
      //             Navigator.pop(context);
      //           }, icon: const Icon(Icons.clear)),
      //           const SizedBox(
      //             width: 10,
      //           ),
      //           // IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
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
        ),
      ),
    );
  }
}
