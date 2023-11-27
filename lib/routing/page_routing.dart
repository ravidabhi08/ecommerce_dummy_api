import 'package:dummy_api/screen/cart/cart_binding.dart';
import 'package:dummy_api/screen/cart/cart_page.dart';
import 'package:dummy_api/screen/home/home_binding.dart';
import 'package:dummy_api/screen/home/home_page.dart';
import 'package:dummy_api/screen/login/login_binding.dart';
import 'package:dummy_api/screen/login/login_page.dart';
import 'package:get/get.dart';
import 'app_routing.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
  ];
}
