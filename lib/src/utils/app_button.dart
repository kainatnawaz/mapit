import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../resources/resources.dart';
import 'heights_widths.dart';

class AppButton extends StatefulWidget {
  final String buttonTitle;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? textSize;
  final double? borderRadius;
  final double? borderWidth;
  final double? letterSpacing;
  final double? textPadding;
  final double? elevation;
  final FontWeight? fontWeight;
  final double? buttonWidth;

  const AppButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.textColor,
    this.borderWidth,
    this.textSize,
    this.letterSpacing,
    this.fontWeight,
    this.textPadding,
    this.elevation,
    this.shadowColor,
    this.buttonWidth,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonWidth ?? Get.width,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          elevation: widget.elevation ?? 3,
          padding: EdgeInsets.zero,
          side: BorderSide(
              color: widget.borderColor ?? R.colors.transparent,
              width: widget.borderWidth ?? 2),
          backgroundColor: widget.color ?? R.colors.themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.textPadding ?? 14.sp),
          child: Text(
            widget.buttonTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: widget.textSize ?? 16.sp,
                fontWeight: widget.fontWeight ?? FontWeight.w500,
                color: widget.textColor ?? R.colors.white,
                letterSpacing: widget.letterSpacing ?? 0.44),
          ),
        ),
      ),
    );
  }
}


////////////////////// 2nd button //////////////////

class AppIconButton extends StatefulWidget {
  final String buttonTitle;
  final String image;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? textSize;
  final double? borderRadius;
  final double? borderWidth;
  final double? letterSpacing;
  final double? textPadding;
  final double? elevation;
  final FontWeight? fontWeight;
  final double? buttonWidth;

  const AppIconButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
    required this.image,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.textColor,
    this.borderWidth,
    this.textSize,
    this.letterSpacing,
    this.fontWeight,
    this.textPadding,
    this.elevation,
    this.shadowColor,
    this.buttonWidth,
  }) : super(key: key);

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonWidth ?? Get.width,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          elevation: widget.elevation ?? 3,
          padding: EdgeInsets.zero,
          side: BorderSide(
              color: widget.borderColor ?? R.colors.transparent,
              width: widget.borderWidth ?? 2),
          backgroundColor: widget.color ?? R.colors.themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.textPadding ?? 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.image,height: 18.sp,width: 18.sp,)
              ,w1,
              Text(
                widget.buttonTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: widget.textSize ?? 16.sp,
                    fontWeight: widget.fontWeight ?? FontWeight.w500,
                    color: widget.textColor ?? R.colors.white,
                    letterSpacing: widget.letterSpacing ?? 0.44),
              ),
            ],
          ),
        ),
      ),
    );
  }
}