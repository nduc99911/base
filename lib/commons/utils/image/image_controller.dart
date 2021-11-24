import 'package:base_pm2/commons/utils/base_view/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImageController extends BaseController {
  late PageController pageController;
  late List<ImageObject> listImage = <ImageObject>[];
  var listImageSelected = <bool>[].obs;
  var pageIndexBase = 0.obs;
  int currentIndex = 0;
  int realPosition = 0;
  var kIsWeb = false.obs;

  @override
  initialData() {
    checkArgument();
    pageController = PageController(initialPage: pageIndexBase.value);
    setIndexImage();
  }

  onChangePager(int index) async {
    pageIndexBase.value = index;
    setIndexImage();
  }

  setIndexImage() {
    listImageSelected.clear();
    for (int i = 0; i < listImage.length; i++) {
      if (i == pageIndexBase.value) {
        listImageSelected.add(true);
      } else
        listImageSelected.add(false);
    }
  }

  void checkArgument() {
    listImage = Get.arguments[0];
    if (Get.arguments.length == 3) {
      kIsWeb.value = Get.arguments[2];
    }
    pageIndexBase.value = Get.arguments[1];
  }
}

class ImageObject {
  String? name;
  String? title;
  String? path;

  ImageObject({this.name, this.path});
}
