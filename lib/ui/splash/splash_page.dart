import 'package:base_pm2/ui/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetWidget<SplashController> {
  final _controller = Get.lazyPut(() => SplashController());

  @override
  Widget build(BuildContext context) => Container();
}
