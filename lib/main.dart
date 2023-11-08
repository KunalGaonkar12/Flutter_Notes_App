import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notesapp/Feature/homescreen/home_screen.dart';
import 'package:notesapp/config/routes/route.dart';
import 'package:notesapp/feature/app/hive_adapters.dart';
import 'package:provider/provider.dart';
import 'feature/app/providers.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  RegisterAdapters.registerHiveAdapters();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: Providers.getAllProviders(),
      child:MaterialApp(
      title: 'Flutter Demo',
        onGenerateRoute:AppRoutes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
     ));
  }
}



