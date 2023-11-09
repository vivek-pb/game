import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static final instance = HiveManager._();
  HiveManager._();
  static String _hiveBox = "";

  static String get hiveBox => _hiveBox;

  init(String hiveBox) {
    _hiveBox = hiveBox;
  }

  ///Pass your model in string /// PersonModel.toJson()
  addData({required Map<String, dynamic> data}) async {
    var box = await Hive.openBox(hiveBox);

    await box.add(data);
    Hive.close();
  }

  getData() async {
    var box = await Hive.openBox(hiveBox);

    return box;
  }

  deleteAtIndex(int index) async {
    var box = await Hive.openBox(hiveBox);
    await box.deleteAt(index);
  }

  deleteAllData() async {
    var box = await Hive.openBox(hiveBox);
    await box.clear();
  }

  updateAtIndex(
      {required int index, required Map<String, dynamic> data}) async {
    var box = await Hive.openBox(hiveBox);
    await box.putAt(index, data);
  }
}
