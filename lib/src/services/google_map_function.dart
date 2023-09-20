import 'dart:developer';

import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';
import 'package:mapit/src/constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapFunctions {
  static bool isList = true;
  static LatLng defaultLatLng = const LatLng(lat: 31.4564555, lng: 74.2852029);
  static FindAutocompletePredictionsResponse? predictions;
  static final places = FlutterGooglePlacesSdk(Constants.mapKey);
  static Future<void> predict(String val) async {
    isList = true;
    predictions = await places.findAutocompletePredictions(val);

    if (val.isEmpty) {
      predictions = null;
    }

    log('Result: $predictions');
  }

  static Future<bool> checkLocation({bool showError = true}) async {
    bool isPremissionGranted = false;
    PermissionStatus status = await Permission.location.status;

    if (status == PermissionStatus.denied) {
      if (showError) {
        // ZBotToast.showToastError(message: "Permission is denied");
        Get.snackbar("Error", "permission is denied");
      }

      await Permission.location.request();
    } else if (status == PermissionStatus.granted) {
      isPremissionGranted = true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      if (showError) {
        Get.snackbar("Error", "permission is denied");

        await openAppSettings();
      }
    }
    return isPremissionGranted;
  }
}
