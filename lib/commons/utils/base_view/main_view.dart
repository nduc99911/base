import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:base_pm2/commons/utils/base_view/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils.dart';

class MainView extends StatefulWidget {
  Widget? body;
  String? title;
  Decoration? decoration;
  List<Widget>? action;
  FloatingActionButton? floatingActionButton;
  Function? functionLeading;
  Function? functionAction;
  bool? isLeading = true;
  Function? onTapBackground;
  Widget? endDrawer;

  MainView(
      {this.body,
      this.title,
      this.decoration,
      this.action,
      this.floatingActionButton,
      this.functionLeading,
      this.functionAction,
      this.isLeading,
      this.onTapBackground,
      this.endDrawer});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTapBackground?.call();
        Utils.hideKeyboard(Get.context!);
        Get.focusScope!.unfocus();
      },
      child: Container(
        height: Get.height,
        decoration: widget.decoration,
        child: Scaffold(
          floatingActionButton: widget.floatingActionButton,
          endDrawer: widget.endDrawer,
          backgroundColor: ColorResource.transparent,

          // resizeToAvoidBottomInset: true,
          appBar: BaseAppBar(
              isLight: true,
              title: widget.title,
              backgroundColor: ColorResource.transparent,
              functionLeading: () =>
                  widget.functionLeading?.call() ?? Get.back(),
              flexibleSpace: Container(
                decoration: BoxDecoration(color: ColorResource.colorPrimary
                    // image: DecorationImage(
                    //   fit: BoxFit.fill,
                    //   image: null,
                    // ),
                    ),
              ),
              isLeading: widget.isLeading,
              functionAction: () => widget.functionAction?.call(),
              action: widget.action ?? []),
          body: widget.body!,
        ),
      ),
    );
  }
}
