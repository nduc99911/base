import 'package:base_pm2/commons/resource/app_resource.dart';
import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils.dart';

class DropdownCustom extends StatefulWidget {
  Widget? widgetLeft, widgetRight, widgetAfterLeft, widgetRight2nd;
  BoxConstraints? suffixConstraint, prefixConstraint;
  String? currentValue, hint, error, label;
  int? index;
  List? listItems = [];
  Widget? widgetAbove, widgetBelow;
  OutlineInputBorder? enableBorder,
      focusBorder,
      disableBorder,
      errorBorder,
      focusedErrorBorder;
  double? borderRadius;
  Function? onValidator;
  Function? getCurrentValue;

  DropdownCustom(
      {this.widgetLeft,
      this.widgetRight,
      this.widgetAfterLeft,
      this.currentValue,
      this.hint,
      this.index,
      this.listItems,
      this.widgetRight2nd,
      this.widgetBelow,
      this.widgetAbove,
      this.borderRadius,
      this.prefixConstraint,
      this.enableBorder,
      this.getCurrentValue,
      this.focusBorder,
      this.disableBorder,
      this.errorBorder,
      this.focusedErrorBorder,
      this.suffixConstraint,
      this.error,
      this.onValidator,
      this.label});

  @override
  State<StatefulWidget> createState() {
    return DropdownCustomState();
  }
}

class DropdownCustomState extends State<DropdownCustom> {
  final GlobalKey dropdownKey = GlobalKey();
  Color? _labelColor;
  Color? _highColor = ColorResource.colorPrimary;
  Color? _lowColor = ColorResource.grey;
  OutlineInputBorder? _outlineInputBorder;
  OutlineInputBorder? _outlineInputBorderError;
  var _dropdownFormFieldKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.listItems == null)
      _outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        borderSide:
            const BorderSide(width: 1, color: ColorResource.colorPrimary),
      );
    _outlineInputBorderError = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      borderSide: const BorderSide(width: 1, color: ColorResource.red),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DropdownCustom oldWidget) {
    widget.listItems = oldWidget.listItems;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: Get.width,
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() => _labelColor = hasFocus ? _highColor : _lowColor);
              },
              child: Form(
                key: _dropdownFormFieldKey,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    errorStyle:
                        const TextStyle(fontSize: 11, color: Colors.red),
                    errorText: widget.error ?? null,
                    errorMaxLines: 1,

                    filled: true,
                    fillColor: ColorResource.colorPrimary,
                    labelText: widget.label ?? widget.hint ?? '',
                    labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: AppResource.medium,
                        color: _labelColor),
                    isDense: false,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          width: 1, color: ColorResource.colorPrimary),
                    ),
                    focusedBorder: widget.focusBorder ?? _outlineInputBorder,
                    disabledBorder: widget.disableBorder ?? _outlineInputBorder,
                    errorBorder: widget.errorBorder ?? _outlineInputBorderError,
                    focusedErrorBorder:
                        widget.focusedErrorBorder ?? _outlineInputBorder,
                    prefixIcon: widget.widgetLeft,
                    prefixIconConstraints: widget.prefixConstraint ??
                        BoxConstraints(
                          minHeight: 50,
                          maxWidth: 40,
                        ),
                    suffixIconConstraints: widget.suffixConstraint ??
                        BoxConstraints(minHeight: 0, minWidth: 0, maxWidth: 30),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: widget.widgetRight ??
                          Icon(Icons.arrow_drop_down_outlined),
                    ),
                    // border: new CustomBorderTextFieldSkin().getSkin(),
                  ),
                  validator: (value) => widget.onValidator?.call(value),
                  key: dropdownKey,
                  menuMaxHeight: Get.height / 2,
                  value: widget.currentValue == '' ? null : widget.currentValue,
                  isExpanded: true,
                  isDense: false,
                  icon: Utils.getSpaceView(0, 0),
                  style: TextStyle(
                      fontSize: 14,
                      color: ColorResource.black,
                      fontWeight: AppResource.medium),
                  onTap: () {
                    Get.focusScope!.unfocus();
                  },
                  onChanged: (value) {
                    if (_dropdownFormFieldKey.currentState != null) {
                      if (_dropdownFormFieldKey.currentState!.validate()) {
                        _dropdownFormFieldKey.currentState!.save();
                      }
                    }
                  },
                  items: widget.listItems!.map((value) {
                    return DropdownMenuItem<String>(
                        onTap: () {
                          Get.focusScope!.unfocus();
                          widget.getCurrentValue
                              ?.call(value, widget.index ?? 0);
                        },
                        value: value.title,
                        child: Text(
                          (value.title! as String),
                          style: TextStyle(
                              fontSize: 15,
                              color: ColorResource.colorPrimary,
                              fontWeight: AppResource.bold),
                        ));
                  }).toList(),
                  selectedItemBuilder: (context) => widget.listItems!
                      .map(
                        (value) => Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (value.title! as String),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ColorResource.colorPrimary,
                                fontSize: 14,
                                fontWeight: AppResource.medium),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  openDropdownAnyWhere() {
    Get.focusScope!.unfocus();
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget != null && element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
          return;
        } else {
          searchForGestureDetector(element);
        }
        return;
      });
    }

    searchForGestureDetector(dropdownKey.currentContext!);
    detector!.onTap!();
  }
}
