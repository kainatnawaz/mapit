import 'package:flutter/material.dart';

import 'resources.dart';

class AppDecoration {
  InputDecoration fieldDecoration({
    Widget? preIcon,
    required String labelText,
    required String hintText,
    Widget? suffixIcon,
    double? radius,
    double? horizontalPadding,
    double? verticalPadding,
    double? iconMinWidth,
    Color? fillColor,
    FocusNode? focusNode,
    bool? isLabelTranslated = true
  }) {
    return InputDecoration(
      suffixIconConstraints: BoxConstraints(
          minWidth: iconMinWidth ?? 60,
          minHeight: 50,maxHeight: 50
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 16, vertical: verticalPadding ?? 14),
      fillColor: fillColor ?? R.colors.white,
      labelText:  labelText,
      labelStyle:TextStyle(fontSize: 13,color: R.colors.hintGrey),
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: preIcon,
      suffixIcon: suffixIcon != null ? Container(child: suffixIcon) : null,
      hintStyle: TextStyle(
        color: R.colors.hintGrey,
        fontSize: 13,
        fontWeight:
        focusNode?.hasFocus ?? false ? FontWeight.w400 : FontWeight.w400,
      ),
      isDense: true,
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 14)),
        borderSide: BorderSide(color: R.colors.hintGrey.withOpacity(.40)),
      ),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 14)),
        borderSide: BorderSide(color: R.colors.hintGrey.withOpacity(.40)),
      ),
      disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 14)),
        borderSide: BorderSide(color: R.colors.hintGrey.withOpacity(.40)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 14)),
        borderSide: BorderSide(color: R.colors.themeColor),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 14)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 14)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      filled: true,
    );
  }

  InputDecoration filledDecoration({
    Widget? preIcon,
    required String hintText,
    Widget? suffixIcon,
    double? radius,
    double? horizontalPadding,
    double? verticalPadding,
    double? iconMinWidth,
    Color? fillColor,
    Color? borderColor,
    FocusNode? focusNode,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius??15),
        borderSide: BorderSide(
          width: 1.0,
          color: borderColor??R.colors.uploadBorderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius??15),
        borderSide: BorderSide(
          width: 1.0,
          color:  borderColor??R.colors.uploadBorderColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius??15),
        borderSide: BorderSide(
          width: 1.0,
          color:  borderColor??R.colors.uploadBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius??15),
        borderSide: BorderSide(
          width: 1.0,
          color: borderColor?? R.colors.uploadBorderColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius??15),
        borderSide: BorderSide(
          width: 1.0,
          color: R.colors.red,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius??15),
        borderSide: BorderSide(
          width: 1.0,
          color: R.colors.red,
        ),
      ),
      filled: true,
      fillColor: fillColor,
      hintStyle:TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: R.colors.hintGrey,
      ),
    );
  }
}
