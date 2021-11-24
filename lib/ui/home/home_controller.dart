import 'package:base_pm2/commons/resource/enum_resource.dart';
import 'package:base_pm2/commons/utils/base_view/base_controller.dart';
import 'package:base_pm2/model/test.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  var string = ''.obs;
  var listEntries = <Entries>[].obs;

  @override
  initialData() async {
    await handleDelay(1000);
    await super.initialData();
  }

  /// Hàm chính để call api
  @override
  getDataSuccessFromAPI() async {
    var test = await client.getTests();

    listEntries.value = test.entries!;

    /// sử dụng setEndpoint để tránh loadmore khi api đã hết
    setEndPoint(listEntries.length > 10);

    /// sử dụng setStatus để điều khiển loading
    setStatus(Status.success);
  }
}
