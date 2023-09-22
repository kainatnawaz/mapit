import 'package:flutter/material.dart';
import 'package:mapit/src/utils/permission_popup.dart';
import 'package:permission_handler/permission_handler.dart';


class GlobalFunctions {
  static DateTime? currentBackPressTime;
  static Future<bool?> checkPermissionStatus(PermissionStatus status , BuildContext context) async {
    switch (status) {
      case PermissionStatus.denied:
        if (!await Permission.location.request().isGranted) {
          showDialog(context: context, builder: (c)=>const PermissionDialog());
        } else {
          return true;
        }
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        showDialog(context: context, builder: (c)=>const PermissionDialog());

        return false;
      case PermissionStatus.limited:
        showDialog(context: context, builder: (c)=>const PermissionDialog());

        return false;
      case PermissionStatus.permanentlyDenied:
        showDialog(context: context, builder: (c)=>const PermissionDialog());

        return false;
      case PermissionStatus.provisional:
        // TODO: Handle this case.
    }
    return null;
  }

  snackBarWidget(String content){
    final snackBar = SnackBar(
      content: const Text('Yay! A SnackBar!'),
    );
    return snackBar;
  }
}

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

