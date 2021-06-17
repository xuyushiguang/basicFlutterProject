import 'package:flutter/material.dart';
import './pages/Home.dart';

class RouterName {
  static const String main = '/';//默认根页面
}

class MyRouter {
//定义一个单例
  factory MyRouter() => _getInstance();
  static MyRouter ? _instance;
  MyRouter._internal();
  static MyRouter _getInstance() {
    if (_instance == null) {
      _instance = MyRouter._internal();
    }
    return _instance!;
  }
//定义一个全局的NavigatorState上下文，
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => navigatorKey.currentState!;
  //以后跳转页面就用下面的方法
  get pushNamed => navigator.pushNamed;
  get push => navigator.push;
  get pop => navigator.pop;
  get popAndPushNamed => navigator.popAndPushNamed;

//定义一个方法，按照MaterialApp的onGenerateRoute属性定义，
//当调用pushNamed跳转页面时，会根据传入的name参数到RouteSettings，
 // 然后再方法里面匹配字符串去跳转相应的页面。
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.main:
        return MaterialPageRoute(builder: (context) => Home());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
