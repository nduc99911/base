import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:base_pm2/commons/utils/base_view/base_view.dart';
import 'package:base_pm2/commons/utils/base_view/main_view.dart';
import 'package:base_pm2/commons/utils/image/render_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import 'home_controller.dart';

class HomePage extends GetWidget<HomeController> {
  final _controller = Get.lazyPut(() => HomeController());

  @override
  Widget build(BuildContext context) {
    return MainView(
      title: 'Base PM2',
      isLeading: false,
      decoration: BoxDecoration(color: ColorResource.white),
      body: body(),
    );
  }

  Widget body() {
    return Obx(
      () => BaseView(
        status: controller.status.value,
        onSuccess: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.listEntries
                  .mapIndexed(
                    (index, element) => Text('- ${element.description ?? ''}'),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
