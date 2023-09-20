
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapit/src/resources/resources.dart';
import 'package:mapit/src/services/geo_hash_service.dart';
import 'package:mapit/src/services/google_map_function.dart';
import 'package:mapit/src/services/google_map_predict.dart';
import 'package:mapit/src/utils/app_button.dart';
import 'package:mapit/src/utils/global_functions.dart';
import 'package:mapit/src/utils/map_utils.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import 'constants/constants.dart';
import 'model/pick_location_data.dart';



class GoogleMapScreen extends StatefulWidget {
  final ValueChanged<PickLocationData>? address;
  final bool? showButton;
  final LatLng? selectedLocation;

  const GoogleMapScreen({
    Key? key,
    this.address,
    this.showButton = true,
    this.selectedLocation,
  }) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng? startLocation;
  TextEditingController searchTC = TextEditingController();
  GoogleMapController? mapsController;

  Future<void> setCurrentLocation() async {
    startLocation = widget.selectedLocation ??
        LatLng(
          Constants.defaultLat,
          Constants.defaultLng,
        );
    await GeoHashService.getAddress(
        widget.selectedLocation != null
            ? widget.selectedLocation?.latitude ?? Constants.defaultLat
            : Constants.defaultLat,
        widget.selectedLocation != null
            ? widget.selectedLocation?.longitude ?? Constants.defaultLng
            : Constants.defaultLng,
        isSignup: true)
        .then((value) {
      searchTC.text = GeoHashService.address?.streetAddress ?? "";
      mapsController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: widget.selectedLocation != null
            ? (widget.selectedLocation!)
            : LatLng(
          Constants.defaultLat,
          Constants.defaultLng,
        ),
        zoom: 18,
      )));
    });
  }

  BitmapDescriptor? icon1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      GoogleMapFunctions.isList = false;
      await setCurrentLocation();

      // if (widget.selectedLocation == null) {
      //   var locStatus = await Permission.location.status;
      //   bool locCheck = await GlobalFunctions.checkPermissionStatus(locStatus);
      //   if (locCheck) {
      //     await GeoHashService.getLocation(isSignup:true).then((value) {
      //       mapsController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //         target: GeoHashService.signUpCurrentPosition,
      //         zoom: 18,
      //       )));
      //       searchTC.text=GeoHashService.signUpAddress?.streetAddress??Constants.defaultAddress;
      //       startLocation=GeoHashService.signUpCurrentPosition;
      //       setState(() {
      //
      //       });
      //     });
      //   } else {
      //     // await setDefaultLocation();
      //   }
      // }
      // else {
      //   await setCurrentLocation();
      // }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: startLocation == null ? null : Container(
        margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12),
        child: AppButton(
          color: R.colors.themeColor,
          buttonTitle: "Save location",
          textColor: R.colors.white,
          textSize: 16.sp,
          onTap: () {
            widget.address!(GeoHashService.address!);
            Get.back();
          },
        ),
      ),
      body: startLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            onTap: (lat) async {
              if (widget.showButton!) {
                await GeoHashService.getAddress(lat.latitude, lat.longitude, isSignup: true).then((value) {
                  searchTC.text = GeoHashService.address?.streetAddress ?? "";
                  mapsController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                    target: GeoHashService.currentPosition,
                    zoom: 18,
                  )));
                  setState(() {});
                });
              }
            },
            onMapCreated: (controller) async {
              mapsController = controller;
              mapsController?.setMapStyle(Utils.mapStyles);
              mapsController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(startLocation!.latitude, startLocation!.longitude),
                    zoom: 18,
                  ),
                ),
              );
              setState(() {});
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            trafficEnabled: false,
            buildingsEnabled: false,
            compassEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            markers: GeoHashService.markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: startLocation!, zoom: 18),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 12),
            color: R.colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Material(
                      color: R.colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            Get.back();

                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: R.colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        // height: 40,
                        child: TextFormField(
                            readOnly: false,
                            controller: searchTC,
                            onChanged: ((value) async {
                              if (value.isNotEmpty) {
                                await GoogleMapFunctions.predict(value);
                                setState(() {});
                              }
                            }),
                            decoration: R.decoration.filledDecoration(
                              radius: 2,
                              borderColor: R.colors.lightBlue,
                              fillColor: R.colors.lightBlue,
                              hintText: "location",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  if (searchTC.text.isNotEmpty) {
                                    searchTC.clear();
                                    setState(() {});
                                  }
                                },
                                child: Icon(
                                  Icons.cancel_outlined,
                                  color: searchTC.text.isNotEmpty ? Colors.red : Colors.transparent,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Material(
                      color: R.colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 5),
                        child: InkWell(
                          onTap: () async {
                            var locStatus = await Permission.location.status;
                            bool? locCheck = await GlobalFunctions.checkPermissionStatus(locStatus);
                            if (locCheck??false) {
                              await GeoHashService.getLocation(isSignup: true).then((value) {
                                mapsController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                  target: GeoHashService.currentPosition,
                                  zoom: 18,
                                )));
                              });
                              await GeoHashService.getAddress(GeoHashService.currentPosition.latitude,
                                  GeoHashService.currentPosition.longitude,
                                  isSignup: true)
                                  .then((value) {
                                searchTC.text = GeoHashService.address?.streetAddress ?? "";
                                setState(() {});
                              });
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.5.sp, vertical: 8.sp),
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: R.colors.lightBlue,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Icon(
                                Icons.my_location,
                                color: R.colors.themeColor,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
                GoogleMapPredict(
                  predictValue: searchTC.text,
                  address: (addrs) async {
                    GeoHashService.address = addrs;
                    searchTC.text = addrs.streetAddress ?? "";
                    startLocation =
                        LatLng(addrs.lat ?? startLocation!.latitude, addrs.lng ?? startLocation!.longitude);
                    mapsController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                      target: startLocation!,
                      zoom: 18,
                    )));
                    GeoHashService.markers.clear();
                    GeoHashService.markers.add(
                      Marker(markerId: MarkerId("$startLocation"), position: startLocation!,anchor: const Offset(0.5,0.5),),
                    );
                    await GeoHashService.getAddress(startLocation!.latitude, startLocation!.longitude,
                        isSignup: true);
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
