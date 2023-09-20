
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';
import 'app_button.dart';
import 'heights_widths.dart';


class PermissionDialog extends StatefulWidget {
  const PermissionDialog({Key? key}) : super(key: key);

  @override
  State<PermissionDialog> createState() => _PermissionDialogState();
}

class _PermissionDialogState extends State<PermissionDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
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
             "OOPs",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: R.colors.black,
                ),
              ),
              h2,
              Text(
               "please grant required permissions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: R.colors.hintGrey,
                ),
              ),
              h2,
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 7.h),
                child:
                AppButton(
                  color: R.colors.themeColor,
                  buttonTitle:"open_settings",
                  textColor: R.colors.white,
                  textSize: 16.sp,
                  onTap: () async {
                    await openAppSettings();

                  },
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith((states) => R.colors.themeColor.withOpacity(0.05)),
                ),
                onPressed: () {
                  Get.back();
                },
                child:const Text(
                 "Back",
                  style: TextStyle(),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
