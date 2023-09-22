import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapit/src/resources/resources.dart';
import 'package:mapit/src/services/geo_hash_service.dart';
import 'package:mapit/src/services/google_map_function.dart';
import 'package:mapit/src/services/google_map_predict.dart';
import 'package:mapit/src/utils/global_functions.dart';
import 'package:mapit/src/utils/map_utils.dart';

import 'package:permission_handler/permission_handler.dart';

import 'constants/constants.dart';
import 'model/pick_location_data.dart';

class GoogleMapScreen extends StatefulWidget {
  final ValueChanged<PickLocationData> address;
  final VoidCallback onPressBack;
  final bool? showButton;
  final String mapApiKey;
  final double? selectedLocationLat;
  final double? selectedLocationLng;
  final Color? themeColor;
  final Color? buttonTextColor;
  final String? markerImage;
  final String? buttonTitle;
  final String? searchHintText;

  const GoogleMapScreen({
    Key? key,
    required this.address,
    required this.mapApiKey,
    required this.onPressBack,
    this.showButton = true,
    this.themeColor,
    this.markerImage,
    this.selectedLocationLat,
    this.selectedLocationLng, this.buttonTextColor, this.buttonTitle, this.searchHintText,
  }) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng? startLocation;
  TextEditingController searchTC = TextEditingController();
  GoogleMapController? mapsController;
  String? icon1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      icon1 = widget.markerImage;
      GoogleMapFunctions.isList = false;
      Constants.mapKey = widget.mapApiKey;
      setState(() {});
      await setCurrentLocation();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: false,
        bottomNavigationBar: startLocation == null
            ? null
            : Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .12,
                    0,
                    MediaQuery.of(context).size.width * .12,
                    12),
                child: saveButtonWidget(
                  buttonWidth: MediaQuery.of(context).size.width * .8,
                  color: widget.themeColor ?? R.colors.themeColor,
                  buttonTitle: widget.buttonTitle ?? "Save location",
                  textColor: widget.buttonTextColor ?? R.colors.white,
                  textSize: MediaQuery.of(context).size.width * .05,
                  onTap: () {
                    widget.address(GeoHashService.address!);
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
                        await GeoHashService.getAddress(
                                icon1: icon1,
                                lat.latitude,
                                lat.longitude,
                                isSignup: true)
                            .then((value) {
                          searchTC.text =
                              GeoHashService.address?.streetAddress ?? "";
                          mapsController?.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
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
                            target: LatLng(startLocation!.latitude,
                                startLocation!.longitude),
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
                    initialCameraPosition:
                        CameraPosition(target: startLocation!, zoom: 18),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: widget.onPressBack,
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
                                      hintText: widget.searchHintText ?? "location",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          if (searchTC.text.isNotEmpty) {
                                            searchTC.clear();
                                            GoogleMapFunctions.isList = false;
                                            setState(() {});
                                          }
                                        },
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          color: searchTC.text.isNotEmpty
                                              ? Colors.red
                                              : Colors.transparent,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Material(
                              color: R.colors.transparent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 5),
                                child: InkWell(
                                  onTap: () async {
                                    GoogleMapFunctions.isList = false;
                                    var locStatus =
                                        await Permission.location.status;
                                    bool? locCheck = await GlobalFunctions
                                        .checkPermissionStatus(
                                            locStatus, context);
                                    if (locCheck ?? false) {
                                      await GeoHashService.getLocation(
                                        isSignup: true,
                                        icon1: icon1,
                                      ).then((value) {
                                        mapsController?.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                          target:
                                              GeoHashService.currentPosition,
                                          zoom: 18,
                                        )));
                                      });
                                      await GeoHashService.getAddress(
                                              icon1: icon1,
                                              GeoHashService
                                                  .currentPosition.latitude,
                                              GeoHashService
                                                  .currentPosition.longitude,
                                              isSignup: true)
                                          .then((value) {
                                        searchTC.text = GeoHashService
                                                .address?.streetAddress ??
                                            "";
                                        setState(() {});
                                      });
                                    }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .03,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .03),
                                      margin: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: R.colors.lightBlue,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Icon(
                                        Icons.my_location,
                                        color: widget.themeColor ?? R.colors.themeColor,
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
                            startLocation = LatLng(
                                addrs.lat ?? startLocation!.latitude,
                                addrs.lng ?? startLocation!.longitude);
                            mapsController?.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                              target: startLocation!,
                              zoom: 18,
                            )));
                            GeoHashService.markers.clear();
                            GeoHashService.markers.add(
                              Marker(
                                markerId: MarkerId("$startLocation"),
                                position: startLocation!,
                                anchor: const Offset(0.5, 0.5),
                              ),
                            );
                            await GeoHashService.getAddress(
                                startLocation!.latitude,
                                startLocation!.longitude,
                                icon1: icon1,
                                isSignup: true);
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  ///WIDGETS
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
                fontSize: textSize ?? 16,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? R.colors.white,
                letterSpacing: letterSpacing ?? 0.44),
          ),
        ),
      ),
    );
  }

  ///FUNCTIONS

  Future<void> setCurrentLocation() async {
    startLocation = LatLng(widget.selectedLocationLat ?? Constants.defaultLat,
        widget.selectedLocationLng ?? Constants.defaultLng);
    await GeoHashService.getAddress(
      widget.selectedLocationLat != null
          ? widget.selectedLocationLat ?? Constants.defaultLat
          : Constants.defaultLat,
      widget.selectedLocationLng != null
          ? widget.selectedLocationLng ?? Constants.defaultLng
          : Constants.defaultLng,
      isSignup: true,
      icon1: icon1,
    ).then((value) {
      searchTC.text = GeoHashService.address?.streetAddress ?? "";
      mapsController
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: widget.selectedLocationLat != null
            ? (startLocation!)
            : LatLng(
                Constants.defaultLat,
                Constants.defaultLng,
              ),
        zoom: 18,
      )));
    });
  }
}
