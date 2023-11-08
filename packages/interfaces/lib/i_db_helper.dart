library interfaces;

import 'package:hive/hive.dart';

mixin class IDBHelper{

  //To fetch data
  Future<List<T>> fetchData<T>(String boxname) async {
    Box _box = await Hive.openBox<T>(boxname);
   var  list = _box.values.toList()  as  List<T>;
    //  _box.close();
    return list;
  }

  //To save data
  saveData<T>(T data, String boxName,
      {bool deleteBoxDataIfEmpty = false,
        deleteKeys = true,
        closeBox = false}) async {
    if (data != null) {
      Box box = await Hive.openBox<T>(boxName);
     box.add(data);
      }
    }

    //To update data
  updateData<T>(int index,T data, String boxName,
      {bool deleteBoxDataIfEmpty = false,
        deleteKeys = true,
        closeBox = false}) async {
    if (data != null) {
      Box box = await Hive.openBox<T>(boxName);
      var  list = box.values.toList()  as  List<T>;
      list[index]=data;
      final keys = box.keys;
      box.deleteAll(keys);
      box.addAll(list);
    }
    }

//To delete data
  deleteData<T>(int index,String boxName) async {
    Box box = await Hive.openBox<T>(boxName);
    box.deleteAt(index);
  }

  }


