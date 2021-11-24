// Do Manh Tai - 04-08-2021/08/2021

import 'package:base_pm2/commons/resource/app_resource.dart';
import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class TextFieldCustom extends StatefulWidget {
  Widget? widgetLeft, widgetRight, widgetAfterLeft;
  TextInputType? inputType;
  TextInputAction? inputAction;
  TextEditingController? editingController;
  TextStyle? style, hintStyle;
  String? label;
  String? hint;
  String? error;
  Function? onTap;
  Function? onChange;
  Function? onComplete;
  bool? isReadOnly;
  int? minLine, maxLines;
  double? padH, padV, borderRadius;
  TextCapitalization? capitalization;
  Color? backgroundColor;
  Color? borderColor;
  Color? fillColor;
  Widget? widgetAbove, widgetBelow;
  BoxConstraints? suffixConstraint, prefixConstraint;
  OutlineInputBorder? enableBorder,
      focusBorder,
      disableBorder,
      errorBorder,
      focusedErrorBorder;
  EdgeInsetsGeometry? contentPadding;
  Function? onValidator;
  List<TextInputFormatter>? inputFormatters;
  bool? isDoubleNum;

  TextFieldCustom({
    this.widgetLeft,
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
    this.padV,
    this.capitalization,
    this.backgroundColor,
    this.borderColor,
    this.suffixConstraint,
    this.focusedErrorBorder,
    this.errorBorder,
    this.disableBorder,
    this.focusBorder,
    this.enableBorder,
    this.fillColor,
    this.inputAction,
    this.error,
    this.label,
    this.borderRadius,
    this.contentPadding,
    this.inputFormatters,
    this.hintStyle,
    this.onValidator,
    this.prefixConstraint,
    this.style,
    this.isDoubleNum,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
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
    widget.isDoubleNum = widget.isDoubleNum ?? false;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.widgetAbove ?? Utils.getSpaceView(0, 0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Focus(
                  onFocusChange: (hasFocus) {
                    setState(
                        () => _labelColor = hasFocus ? _highColor : _lowColor);
                  },
                  child: Form(
                    key: _textFormFieldKey,
                    child: Container(
                      child: TextFormField(
                        controller: widget.editingController,
                        onChanged: (String value) {
                          widget.onChange?.call(value);
                          if (_textFormFieldKey.currentState != null) {
                            if (_textFormFieldKey.currentState!.validate()) {
                              _textFormFieldKey.currentState!.save();
                            }
                          }
                        },
                        validator: (value) =>
                            widget.onValidator?.call(value) ?? null,
                        onEditingComplete: () =>
                            widget.onComplete?.call() ?? null,
                        onTap: () => widget.onTap?.call() ?? null,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).nextFocus();
                          FocusScope.of(context).nextFocus();
                        },
                        inputFormatters: widget.inputFormatters ??
                            ((widget.inputType == TextInputType.number)
                                ? (!widget.isDoubleNum!
                                    ? [FilteringTextInputFormatter.digitsOnly]
                                    : [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9.]'))
                                      ])
                                : []),
                        textCapitalization: widget.capitalization ??
                            TextCapitalization.sentences,
                        textInputAction:
                            widget.inputAction ?? TextInputAction.next,
                        minLines: widget.minLine,
                        maxLines: widget.maxLines,
                        keyboardType: widget.inputType,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: widget.isReadOnly ?? false,
                        style: widget.style ??
                            TextStyle(
                                fontSize: 15, fontWeight: AppResource.medium),
                        decoration: InputDecoration(
                          errorStyle:
                              const TextStyle(fontSize: 11, color: Colors.red),
                          errorText: widget.error ?? null,
                          errorMaxLines: 1,
                          filled: true,
                          fillColor:
                              widget.fillColor ?? ColorResource.colorPrimary,
                          labelText: widget.label ?? widget.hint,
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: AppResource.medium,
                              color: _labelColor),
                          alignLabelWithHint: true,
                          hintText: widget.hint,
                          hintStyle: (widget.hintStyle ??
                              const TextStyle(
                                  fontSize: 14,
                                  fontWeight: AppResource.medium)),
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
                          disabledBorder:
                              widget.disableBorder ?? _outlineInputBorder,
                          errorBorder:
                              widget.errorBorder ?? _outlineInputBorderError,
                          focusedErrorBorder:
                              widget.focusedErrorBorder ?? _outlineInputBorder,
                          contentPadding: widget.contentPadding ??
                              EdgeInsets.symmetric(
                                vertical: widget.padV ?? 16,
                                horizontal: widget.padH ?? 8,
                              ),
                          isDense: true,
                          prefixIcon: widget.widgetLeft,
                          prefixIconConstraints: widget.prefixConstraint ??
                              BoxConstraints(
                                minHeight: 50,
                                maxWidth: 40,
                              ),
                          suffixIconConstraints: widget.suffixConstraint ??
                              BoxConstraints(
                                minHeight: 0,
                                minWidth: 0,
                              ),
                          suffixIcon: widget.widgetRight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              widget.widgetBelow ?? Utils.getSpaceView(0, 0),
            ],
          ),
        ],
      ),
    );
  }
}
