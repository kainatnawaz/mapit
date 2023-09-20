import 'package:get/get.dart';
import 'package:mapit/src/utils/permission_popup.dart';
import 'package:permission_handler/permission_handler.dart';


class GlobalFunctions {
  static DateTime? currentBackPressTime;
  static Future<bool?> checkPermissionStatus(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.denied:
        if (!await Permission.location.request().isGranted) {
          Get.dialog(const PermissionDialog());
        } else {
          return true;
        }
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        Get.dialog(const PermissionDialog());

        return false;
      case PermissionStatus.limited:
        Get.dialog(const PermissionDialog());

        return false;
      case PermissionStatus.permanentlyDenied:
        Get.dialog(const PermissionDialog());

        return false;
      case PermissionStatus.provisional:
        // TODO: Handle this case.
    }
    return null;
  }

}
