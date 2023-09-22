import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../resources/resources.dart';

class PermissionDialog extends StatefulWidget {
  const PermissionDialog({Key? key}) : super(key: key);

  @override
  State<PermissionDialog> createState() => _PermissionDialogState();
}

class _PermissionDialogState extends State<PermissionDialog> {
  @override
  Widget build(BuildContext context) {
    log("___HERE");
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.02),
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
              vertical: MediaQuery.of(context).size.height * 0.04),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: R.colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: R.colors.black.withOpacity(0.16),
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Oops!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: R.colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Please grant required permissions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: R.colors.hintGrey,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              saveButtonWidget(
                width: MediaQuery.of(context).size.width * 0.6,borderRadius: 10.0,
                color: R.colors.themeColor,
                buttonTitle:"Open Settings",
                textColor: R.colors.white,
                textSize: 16,
                onTap: () async {
                  await openAppSettings();

                },
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => R.colors.themeColor.withOpacity(0.05)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Back",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget saveButtonWidget(
      {buttonWidth,
      color,
      buttonTitle,
      textColor,
      textSize,
      elevation,
      borderColor,
      borderWidth,
      borderRadius,
      fontWeight,
      width,
      textPadding,
      letterSpacing,
      onTap}) {
    return SizedBox(
      width: width ?? 80,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 3,
          padding: EdgeInsets.zero,
          side: BorderSide(
              color: borderColor ?? R.colors.transparent,
              width: borderWidth ?? 2),
          backgroundColor: color ?? R.colors.themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: textPadding ?? 14),
          child: Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: double.parse(textSize.toString()),
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? R.colors.white,
                letterSpacing: letterSpacing ?? 0.44),
          ),
        ),
      ),
    );
  }
}
