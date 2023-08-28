import 'package:flutter/material.dart';
import 'package:notesapp/Feature/homescreen/home_screen.dart';
import 'package:provider/provider.dart';


import 'Feature/addnotescreen/note_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> NoteProvider()),
  ],child: const MyApp())

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}



