import 'dart:io';

import 'package:base_pm2/commons/resource/app_resource.dart';
import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:base_pm2/commons/utils/image/render_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_controller.dart';

class ImagePage extends GetWidget<ImageController> {
  final _controller = Get.lazyPut(() => ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Stack(children: [
            PageView(
              onPageChanged: (value) => controller.onChangePager(value),
              controller: controller.pageController,
              children: controller.listImage
                  .map(
                    (e) => Container(
                      color: Colors.black,
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: EdgeInsets.all(0),
                            minScale: 1,
                            maxScale: 10,
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              child: Semantics(
                                label: 'image_picker_example_picked_image',
                                child: controller.kIsWeb.value
                                    ? RenderImage.imageNetwork(e.path ?? '')
                                    : Image.file(
                                        File(e.path ?? ''),
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              width: Get.width,
                              margin: EdgeInsets.only(
                                top: 28,
                                left: 56,
                                right: 56,
                              ),
                              color: ColorResource.black.withOpacity(0.5),
                              child: Text(
                                e.name ?? '',
                                style: AppResource.black_15.copyWith(
                                  color: ColorResource.white,
                                  fontWeight: AppResource.medium,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorResource.black.withOpacity(0.5)),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon:
                        Icon(Icons.clear, color: ColorResource.white, size: 28),
                  ),
                ),
              ),
            ),
            Obx(
              () => Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.listImageSelected
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 32),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: e
                                    ? ColorResource.white
                                    : ColorResource.grey,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
