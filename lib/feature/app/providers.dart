
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../addnotescreen/note_provider.dart';

class Providers {
  static List<SingleChildWidget> getAllProviders() {
    List<SingleChildWidget> _providers = [
      ChangeNotifierProvider(create: (context) => NoteProvider()),

    ];
    return _providers;
  }
}
