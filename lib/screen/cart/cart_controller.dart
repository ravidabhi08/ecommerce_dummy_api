import 'package:dummy_api/api_service/http_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var products = [].obs;
  var total = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    // Simulate an asynchronous operation
    dynamic data = await fetchCart();
    // Update the parameter in the controller
    products.value = data['products'];
    total.value = data['total'] as int;
  }
}
