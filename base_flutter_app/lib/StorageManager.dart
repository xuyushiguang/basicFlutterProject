import 'dart:io';
import 'package:flutter_file_path_provider/flutter_file_path_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart' as path;

class StorageManager {

  ///用来本地存储
  ///可以用sharedPreferences.setBool("key",true),这样存储值
  static SharedPreferences ? sharedPreferences;

  ///
  static LocalStorage ? localStorage;

  ///临时目录
  static Directory ? temporaryDirectory;

  //基础目录
  static String ? baseDirectory;

  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    //创建一个临时目录
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage?.ready;

    // 获取本地文档目录
    if (Platform.isAndroid) {
      //获取安卓路径
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      FlutterFilePathProvider.instance.getExternalStorageDirectory().then((result) {
        if (result.code == 0) {
          baseDirectory = result.directory.path + "base/${packageInfo.packageName}";

          //创建一个图片文件夹
          String imgPath = baseDirectory! + "/images";

        }
      });
    } else {
      //获取iOS路径
      baseDirectory = (await getApplicationDocumentsDirectory()).path;

      //创建一个图片文件夹
      String imgPath = baseDirectory! + "/images";
    }

  }
}
