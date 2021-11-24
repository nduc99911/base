import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color_resource.dart';

class AppResource {
  static const TextStyle black_10 = TextStyle(
    fontSize: 10,
    color: ColorResource.black,
    fontWeight: medium,
  );
  static const TextStyle black_11 = TextStyle(
    fontSize: 11,
    color: ColorResource.black,
    fontWeight: medium,
  );
  static const TextStyle black_12 = TextStyle(
    fontSize: 12,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static const TextStyle black_13 = TextStyle(
    fontSize: 13,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static const TextStyle blackRegular_13 = TextStyle(
    fontSize: 13,
    color: ColorResource.black,
    fontWeight: regular,
  );

  static const TextStyle black_14 = TextStyle(
    fontSize: 14,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static TextStyle black_15 = TextStyle(
    fontSize: 15,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static const TextStyle black_16 = TextStyle(
    fontSize: 16,
    color: ColorResource.black,
    fontWeight: medium,
  );
  static const TextStyle black_19 = TextStyle(
    fontSize: 19,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static const TextStyle black_17 = TextStyle(
    fontSize: 17,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static TextStyle black_18 = TextStyle(
    fontSize: 18,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static const TextStyle black_20 = TextStyle(
    fontSize: 20,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static const TextStyle black_22 = TextStyle(
    fontSize: 22,
    color: ColorResource.black,
    fontWeight: medium,
  );
  static const TextStyle blackBold_22 = TextStyle(
    fontSize: 22,
    color: ColorResource.black,
    fontWeight: bold,
  );

  static const TextStyle black_32 = TextStyle(
    fontSize: 32,
    color: ColorResource.black,
    fontWeight: medium,
  );

  static TextStyle blackRegular_15 = black_15.copyWith(
    fontWeight: regular,
  );
  static TextStyle blackRegular_16 = black_16.copyWith(
    fontWeight: regular,
  );

  static TextStyle blackRegular_18 = black_18.copyWith(
    fontWeight: regular,
  );
  static TextStyle whiteRegular_18 = black_18.copyWith(
    fontWeight: regular,
    color: ColorResource.white,
  );
  static TextStyle whiteRegular_15 = black_15.copyWith(
    fontWeight: regular,
    color: ColorResource.white,
  );
  static TextStyle whiteMedium_18 = black_18.copyWith(
    fontWeight: medium,
    color: ColorResource.white,
  );
  static TextStyle whiteBold_18 = black_18.copyWith(
    fontWeight: bold,
    color: ColorResource.white,
  );
  static TextStyle greyRegular_15 = black_15.copyWith(
    fontWeight: regular,
    color: ColorResource.grey,
  );

  static TextStyle blackBold_18 = black_18.copyWith(
    fontWeight: AppResource.bold,
  );
  static TextStyle blackBold_20 = black_20.copyWith(
    fontWeight: AppResource.bold,
  );

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
}
