import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import '../constants/api_urls.dart';
import '../constants/constants.dart';
import '../model/pick_location_data.dart';
import 'dart:ui' as ui;
import '../utils/global_functions.dart';
import 'api_service.dart';
import 'google_map_lat_lng.dart';

class GeoHashService {

  static LatLng currentPosition =  LatLng(Constants.defaultLat,Constants.defaultLng);
  static PickLocationData? address;
  static GeoFlutterFire geo = GeoFlutterFire();
  static final ApiRequest _apiRequests = ApiRequest();
  static Set<Marker> markers = {};




  static Future<void> getLocation({bool isSignup = false ,  String? icon1}) async {
    loc.Location location = loc.Location();
    //await location.changeSettings(accuracy: loc.LocationAccuracy.a, interval: 1000, distanceFilter: 0);
    loc.LocationData currentLocation = await location.getLocation();
    currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);

    await getAddress(currentLocation.latitude!, currentLocation.longitude!,isSignup: isSignup , icon1: icon1);
  }

  static Future getAddress(double lat, double lng,{bool isSignup=false ,  String? icon1}) async {
    GoogleMapLatLongModel googleMapLatLongModel = GoogleMapLatLongModel();
    GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
    BitmapDescriptor? customMarker;
    if(icon1 != null ){
      getBytesFromAsset(
        icon1,
      ).then((onValue) {
        customMarker = BitmapDescriptor.fromBytes(onValue, size: const Size(100, 100));
      });
    }
    await _apiRequests.getMap(
        url: ApiUrl.getAddressFromlatlng(lat, lng, Constants.mapKey),
        onSuccess: (res) async {
          googleMapLatLongModel = GoogleMapLatLongModel.fromJson(jsonDecode(res));
            currentPosition = LatLng(lat, lng);
            markers.clear();
            markers.add(
              Marker(
                icon:customMarker??BitmapDescriptor.defaultMarker ,
                markerId: MarkerId("$currentPosition"),
                position: currentPosition,
                anchor: const Offset(0.5,0.5),
              ),
            );
            address = PickLocationData(
                geohash: geoFirePoint.hash,
                lat: googleMapLatLongModel.results?.first.geometry?.location?.lat?.toDouble() ?? Constants.defaultLat,
                lng: googleMapLatLongModel.results?.first.geometry?.location?.lng?.toDouble() ?? Constants.defaultLng,
                country: googleMapLatLongModel.results?.first.addressComponents?.firstWhereOrNull((element) => element.types!.contains("country"))
                    ?.longName ??
                    "",
                city: googleMapLatLongModel.results?.first.addressComponents
                    ?.firstWhereOrNull((element) => element.types!.contains("administrative_area_level_2"))
                    ?.longName ??
                    "",
                state: googleMapLatLongModel.results?.first.addressComponents
                    ?.firstWhereOrNull((element) => element.types!.contains("administrative_area_level_1"))
                    ?.longName ??
                    "",
                streetAddress: googleMapLatLongModel.results?.first.formattedAddress ?? Constants.defaultAddress,
                zipCode: googleMapLatLongModel.results?.first.addressComponents
                    ?.firstWhereOrNull((element) => element.types!.contains("postal_code"))
                    ?.longName ??
                    "");


          // Get.forceAppUpdate();
        },
        onError: (e) {
          log(e.toString());
        });
  }
  static Future<Uint8List> getBytesFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 150, targetHeight: 150);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

}
