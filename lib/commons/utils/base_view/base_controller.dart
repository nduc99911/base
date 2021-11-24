import 'dart:collection';
import 'dart:developer';
import 'package:base_pm2/commons/networks/rest_client.dart';
import 'package:base_pm2/commons/networks/network_utils.dart';
import 'package:base_pm2/commons/resource/enum_resource.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils.dart';
import 'dialog.dart';

class BaseController extends GetxController {
  RefreshController? smartController;
  Rx<Status> status = Status.loading.obs;
  int pageIndex = 1;
  bool isRefreshing = false;
  bool endPoint = false;
  final int pageSize = 10;
  late RestClient client;
  late Map<String, dynamic> map;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (smartController == null)
      smartController = RefreshController(initialRefresh: false);
    await initialData();
  }

  refreshData() async {
    isRefreshing = true;
    pageIndex = 1;

    endPoint = false;
    await getData();
    refreshed();
  }

  loadMoreData() async {
    if (endPoint) {
      isRefreshing = false;
      pageIndex++;
      await getData();
      smartController!.loadComplete();
    } else {
      smartController!.loadNoData();
    }
  }

  initialData() async {
    setStatus(Status.loading);
    await getData();
  }

  getDataSuccessFromAPI() {}

  getJsonObjectRequest() {}

  getParameters() {
    map = HashMap<String, dynamic>();
  }

  getData() async {
    bool check = await NetworkUtils.hasConnection();
    if (check) {
      try {
        client = await NetworkUtils.getClientInstance();
        await getDataSuccessFromAPI();
      } catch (onError) {
        catchError(onError);
      }
    } else {
      setStatus(Status.fail);
    }
  }

  catchError(Object onError) async {
    switch (onError.runtimeType) {
      case DioError:
        final res = (onError as DioError).response;
        try {
          if (res?.statusCode != null) {
            log('---->>>>>>>>>>>>>>>>>>>>>>>' + res!.statusCode.toString());
          }
          Utils.showToast('${res!.statusCode}\n${res.statusMessage}');
        } catch (e) {}

        if (res?.statusCode == 401) {
          ///refresh token
        } else if (res?.statusCode == 502) {
          setStatus(Status.success);
          if (AlertDialogAnimated.alertDialogAnimated == null) {
            AlertDialogAnimated.getInstance();
            //Press ok then set it to null and get back
            AlertDialogAnimated.alertDialogAnimated = null;
            Get.back();
          }
        } else if (res?.statusCode == 403) {
          setStatus(Status.success);
          if (AlertDialogAnimated.alertDialogAnimated == null) {
            AlertDialogAnimated.getInstance();
            //Press ok then set it to null and get back
            AlertDialogAnimated.alertDialogAnimated = null;
            setStatus(Status.success);
            Get.back();
          }
          // await SharedPref.remove(KeyResource.token);
          // PersonManager.getInstance().clearData();
          // PersonManager.getInstance().setLogin();
          // setStatus(Status.fail);
        } else {
          setStatus(Status.fail);
        }
        break;
      default:
    }
  }

  Future<void> handleDelay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  void setStatus(Status s) {
    status.value = s;
  }

  void setEndPoint(bool condition) {
    endPoint = condition;
  }

  void refreshed() {
    if (smartController != null) {
      smartController!.resetNoData();
      smartController!.refreshCompleted();
    }
  }

  @override
  void onClose() {
    if (smartController != null) smartController = null;
    super.onClose();
  }
}
