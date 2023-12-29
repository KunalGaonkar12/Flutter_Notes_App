import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/Feature/addnotescreen/note_provider.dart';
import 'package:notesapp/Feature/addnotescreen/add_note_screen.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:provider/provider.dart';

import '../../services/connection_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    NoteProvider noteProv = Provider.of<NoteProvider>(context, listen: false);
    noteProv.init();
  }

  List<String> list = [
    'Edit',
    'Delete',
  ];

  List<String> colors=[
"0xffE0754F","0xffF7D44C","0xff48D0E2","0xff4AD3B0"
  ];

  @override
  Widget build(BuildContext context) {
    NoteProvider noteProv = Provider.of<NoteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        titleSpacing: 27,
        elevation: 4,
        shadowColor: Color(0xff363434),
        title: Text(
          "Notes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle:
            const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        toolbarHeight: 64,

        // shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(130)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset("assets/icons/app_logo.jpeg"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "My\nNotes",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            noteProv.allNotes.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      scrollDirection: Axis.vertical,
                      itemCount: noteProv.allNotes.length,
                      itemBuilder: (context, index) {
                        Note? note = noteProv.allNotes[index];
                        return GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(12),
                                        right: Radius.circular(12)),
                                    // color: Color(int.parse(colors[Random().nextInt(colors.length)]))),
                                    color: Color(0xffe7bc3b)),
                                margin: const EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(note.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 1),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Expanded(
                                          child: Text(note.content!,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                              maxLines: 5)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          note.dateAdded
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                child: DropdownButton(
                                    borderRadius: BorderRadius.circular(12),
                                    icon: Icon(Icons.more_horiz,
                                        color: Colors.black),
                                    underline: Container(),
                                    hint: null,
                                    items: list.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      if (value == "Edit") {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    AddNoteScreen(
                                                      isUpdate: true,
                                                      note: note,
                                                    )));
                                      } else {
                                        await noteProv.deleteNote(note.id);
                                      }
                                      setState(() {
                                        // dropdownvalue = value!;
                                      });
                                    }),
                                left: 107,
                                right: 0,
                                bottom: 8,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : const Expanded(
                    child: Center(
                      child: Text(
                        "No Notes yet",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            ConnectionManager.isConnected();

            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const AddNoteScreen(isUpdate: false),
                    fullscreenDialog: true));
          },
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          )),
    );
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
