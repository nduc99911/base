import 'package:base_pm2/commons/resource/app_resource.dart';
import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../utils.dart';

class TypeAheadCustom extends StatefulWidget {
  Widget? widgetLeft, widgetRight, widgetAfterLeft;
  TextInputType? inputType;
  TextEditingController? editingController;
  String? hint, error;
  Function? onTap;
  Function? onChange;
  Function? onComplete;
  Function? onSubmitted;
  bool? isReadOnly;
  int? minLine, maxLines;
  double? padH, padV, borderRadius;
  TextCapitalization? capitalization;
  Color? backgroundColor;
  Color? borderColor;
  Widget? widgetAbove, widgetBelow;
  SuggestionsCallback? suggestCallBack;
  Function? onSuggestionSelected;
  Function? onValidator;
  double? border = 0;
  OutlineInputBorder? enableBorder,
      focusBorder,
      disableBorder,
      errorBorder,
      focusedErrorBorder;
  EdgeInsetsGeometry? contentPadding;
  FocusNode? focusNode;
  String? initialValue;
  BoxConstraints? suffixConstraint, prefixConstraint;
  SuggestionsBoxDecoration? suggestionsBoxDecoration;

  TypeAheadCustom(
      {this.widgetLeft,
      this.widgetRight,
      this.widgetAfterLeft,
      this.widgetBelow,
      this.widgetAbove,
      this.inputType,
      this.editingController,
      this.hint,
      this.onChange,
      this.onComplete,
      this.onTap,
      this.isReadOnly,
      this.minLine,
      this.maxLines,
      this.padH,
      this.focusNode,
      this.padV,
      this.prefixConstraint,
      this.capitalization,
      this.backgroundColor,
      this.borderColor,
      this.suffixConstraint,
      this.suggestCallBack,
      this.onSuggestionSelected,
      this.suggestionsBoxDecoration,
      this.onSubmitted,
      this.initialValue,
      this.error,
      this.border});

  @override
  State<TypeAheadCustom> createState() => _TypeAheadCustomState();
}

class _TypeAheadCustomState extends State<TypeAheadCustom> {
  Color? _labelColor;
  Color? _highColor = ColorResource.colorPrimary;
  Color? _lowColor = ColorResource.grey;
  var _textFormFieldKey = GlobalKey<FormState>();
  OutlineInputBorder? _outlineInputBorder;
  OutlineInputBorder? _outlineInputBorderError;

  @override
  void initState() {
    if (_outlineInputBorder == null) {
      _outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        borderSide:
            const BorderSide(width: 1, color: ColorResource.colorPrimary),
      );
    }
    if (_outlineInputBorderError == null) {
      _outlineInputBorderError = OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        borderSide: const BorderSide(width: 1, color: ColorResource.red),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.widgetAbove ?? Utils.getSpaceView(0, 0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // widgetLeft ?? Utils.getSpaceView(0, 0),
              // widgetAfterLeft ?? Utils.getSpaceView(0, 0),
              Expanded(
                flex: 1,
                child: Focus(
                  onFocusChange: (hasFocus) {
                    setState(
                        () => _labelColor = hasFocus ? _highColor : _lowColor);
                  },
                  child: Form(
                    key: _textFormFieldKey,
                    child: TypeAheadFormField(
                      hideSuggestionsOnKeyboardHide: false,
                      suggestionsBoxDecoration:
                          widget.suggestionsBoxDecoration ??
                              SuggestionsBoxDecoration(
                                  hasScrollbar: true,
                                  offsetX: 20,
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width - 72)),
                      // suggestionsBoxVerticalOffset: -50.0,
                      enabled: widget.isReadOnly ?? true,
                      textFieldConfiguration: TextFieldConfiguration(
                        focusNode: widget.focusNode ?? FocusNode(),
                        controller: widget.editingController,
                        onChanged: (String value) {
                          widget.onChange?.call(value);
                          if (_textFormFieldKey.currentState != null) {
                            if (_textFormFieldKey.currentState!.validate()) {
                              _textFormFieldKey.currentState!.save();
                            }
                          }
                        },
                        onSubmitted: (t) {
                          widget.onSubmitted?.call(t);
                          FocusScope.of(context).nextFocus();
                        },
                        textCapitalization: widget.capitalization ??
                            TextCapitalization.sentences,
                        enabled: widget.isReadOnly ?? true,
                        style: const TextStyle(
                            fontSize: 15,
                            color: ColorResource.colorPrimary,
                            fontWeight: AppResource.medium),
                        decoration: InputDecoration(
                          errorText: widget.error,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: widget.padV ?? 16,
                              horizontal: widget.padH ?? 0),
                          isDense: true,
                          labelText: widget.hint,
                          labelStyle: const TextStyle(
                              fontSize: 15, color: ColorResource.grey),
                          hintText: widget.hint,
                          hintStyle: const TextStyle(
                              fontSize: 15, color: ColorResource.grey),
                          filled: true,
                          fillColor: ColorResource.colorPrimary,
                          prefixIconConstraints: widget.prefixConstraint ??
                              BoxConstraints(maxWidth: 45, maxHeight: 50),
                          prefixIcon: widget.widgetLeft,
                          suffixIcon: widget.widgetRight,
                          suffixIconConstraints: widget.suffixConstraint ??
                              BoxConstraints(maxWidth: 45),
                          enabledBorder: widget.enableBorder ??
                              OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    widget.borderRadius ?? 8),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: ColorResource.colorPrimary),
                              ),
                          focusedBorder:
                              widget.focusBorder ?? _outlineInputBorder,
                          disabledBorder: widget.disableBorder ??
                              OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    widget.borderRadius ?? 8),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: ColorResource.colorPrimary),
                              ),
                          errorBorder:
                              widget.errorBorder ?? _outlineInputBorderError,
                          focusedErrorBorder:
                              widget.focusedErrorBorder ?? _outlineInputBorder,
                        ),
                      ),
                      validator: (value) =>
                          widget.onValidator?.call(value) ?? null,
                      suggestionsCallback: (pattern) async =>
                          await widget.suggestCallBack!.call(pattern),
                      itemBuilder: (context, dynamic suggestion) {
                        return ListTile(
                          // title: Text('Default'),
                          title: Text(suggestion.title ?? 'Default'),
                        );
                      },
                      hideOnError: true,
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      hideOnEmpty: true,
                      onSuggestionSelected: (dynamic suggestion) {
                        widget.editingController?.text =
                            suggestion.title ?? 'Default';
                        widget.onSuggestionSelected!.call(suggestion);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          widget.widgetBelow ?? Utils.getSpaceView(0, 0),
        ],
      ),
    );
  }
}
