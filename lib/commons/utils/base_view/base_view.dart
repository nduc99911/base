import 'package:base_pm2/commons/resource/enum_resource.dart';
import 'package:base_pm2/commons/utils/base_view/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils.dart';

class BaseView extends StatefulWidget {
  final Widget? onSuccess;
  final Widget? onLoading;
  final Widget? onEmpty;
  final Widget? onError;
  final Widget? onWaiting;
  final Status? status;
  final bool? canError;

  BaseView(
      {this.onWaiting,
      this.onError,
      this.onSuccess,
      this.onLoading,
      this.onEmpty,
      this.canError,
      required this.status});

  @override
  State<StatefulWidget> createState() {
    return _BaseView();
  }
}

class _BaseView extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    if (widget.status == Status.loading) {
      return widget.onLoading ?? BaseLoading();
    } else if (widget.status == Status.fail) {
      return widget.onError ?? Utils.emptyData();
    } else if (widget.status == Status.empty) {
      return widget.onEmpty ?? Utils.emptyData();
    } else
      return Stack(
        children: [
          widget.onSuccess ?? Utils.getSpaceView(0, 0),
          widget.status == Status.waiting
              ? widget.onWaiting ?? BaseLoading()
              : Utils.getSpaceView(0, 0),
        ],
      );
  }
}
