import 'package:base_pm2/commons/resource/app_resource.dart';
import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils.dart';

class BaseAppBar extends PreferredSize {
  String? title;
  TextStyle? style;
  List<Widget>? action;
  Color? backgroundColor = ColorResource.transparent;
  Color? colorIcon = ColorResource.white;
  double? elevation = 0;
  bool? isLight;
  bool? isLeading = true;
  Widget? flexibleSpace;
  Icon? iconLeading;
  Function? functionLeading;
  Function? functionAction;

  BaseAppBar(
      {this.title,
      this.style,
      this.action,
      this.backgroundColor,
      this.colorIcon,
      this.elevation,
      this.isLight,
      this.isLeading,
      this.flexibleSpace,
      this.iconLeading,
      this.functionLeading,
      this.functionAction})
      : super(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: Container());

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          isLight! ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      title: Text(
        title ?? '',
        style: style ??
            AppResource.black_18.copyWith(
              color: ColorResource.white,
            ),
        overflow: TextOverflow.ellipsis,
      ),
      flexibleSpace: flexibleSpace ?? Container(),
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: (isLeading ?? true)
          ? IconButton(
              splashRadius: 26,
              onPressed: () {
                Utils.hideKeyboard(Get.context!);
                functionLeading?.call() ?? Get.back();
              },
              icon: iconLeading ??
                  const Icon(
                    Icons.arrow_back_rounded,
                    size: 26,
                    color: ColorResource.white,
                  ),
            )
          : null,
      iconTheme: IconThemeData(color: colorIcon),
      actions: functionAction != null
          ? action ??
              <Widget>[
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => functionAction?.call(),
                  splashRadius: 26,
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    size: 28,
                  ),
                )
              ]
          : <Widget>[],
    );
  }
}
