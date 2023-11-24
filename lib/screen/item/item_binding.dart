import 'package:dummy_api/screen/item/item_controller.dart';
import 'package:get/get.dart';

class ItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemController());
  }
}
