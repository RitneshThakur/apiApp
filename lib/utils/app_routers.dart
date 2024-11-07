import 'package:apiapp/pages/joke_page.dart';
import 'package:apiapp/pages/pickup_page.dart';
import 'package:apiapp/pages/quote_page.dart';
import 'package:get/get.dart';
import '../constants/route_constant.dart';
import '../pages/shayari_page.dart';


class AppRoutes {
  AppRoutes._();

  static const initial = RouteConstants.homepage;
  static final routes = [
    GetPage(name: RouteConstants.joke,
        page: () => JokePage(),
        transition: Transition.fade
    ),
    GetPage(name: RouteConstants.shayari,
        page: () => PoetryPage(),
        transition: Transition.fade
    ),
    GetPage(name: RouteConstants.quotes,
        page: () => QuotePage(),
        transition: Transition.fade
    ),
    GetPage(name: RouteConstants.poetry,
        page: () => PickUpLine(),
        transition: Transition.fade
    ),
  ];
}