import 'dart:convert';
import 'dart:math';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapit/src/constants/constants.dart';
import 'package:mapit/src/services/google_map_function.dart';


import '../constants/api_urls.dart';
import '../model/pick_location_data.dart';
import 'api_service.dart';
import 'google_address_model.dart';

class GoogleMapPredict extends StatefulWidget {
  final ValueChanged<PickLocationData>? address;
  final String? predictValue;
  const GoogleMapPredict({super.key, this.address, this.predictValue});

  @override
  State<GoogleMapPredict> createState() => _GoogleMapPredictState();
}

class _GoogleMapPredictState extends State<GoogleMapPredict> {
  final ApiRequest _apiRequests = ApiRequest();
  /*get latlng From address*/
  Future getLatLngFromAddress(String address) async {
    GoogleAddressModel googleAddressModel = GoogleAddressModel();
    debugPrint(ApiUrl.getLatLngFromAddress(address, Constants.mapKey));
    await _apiRequests.getMap(
        url: ApiUrl.getLatLngFromAddress(address, Constants.mapKey),
        onSuccess: (res) async {
          googleAddressModel = GoogleAddressModel.fromJson(jsonDecode(res));

          widget.address!(PickLocationData(
              lat: googleAddressModel.results?.first.geometry?.location?.lat?.toDouble() ??
                  0,
              lng: googleAddressModel.results?.first.geometry?.location?.lng
                  ?.toDouble() ??
                  0,
              country: googleAddressModel.results?.first.addressComponents
                  ?.firstWhereOrNull(
                      (element) => element.types!.contains("country"))
                  ?.longName ??
                  "",
              city: googleAddressModel.results?.first.addressComponents
                  ?.firstWhereOrNull((element) =>
                  element.types!.contains("administrative_area_level_2"))
                  ?.longName ??
                  "",
              state: googleAddressModel.results?.first.addressComponents?.firstWhereOrNull((element) => element.types!.contains("administrative_area_level_1"))?.longName ?? "",
              streetAddress: googleAddressModel.results?.first.formattedAddress ?? "",
              zipCode: googleAddressModel.results?.first.addressComponents?.firstWhereOrNull((element) => element.types!.contains("postal_code"))?.longName ?? ""));

          setState(() {});
        },
        onError: (e) {
          debugPrint(e.toString());
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("_____LEN:${GoogleMapFunctions.predictions?.predictions.length}");
    if (GoogleMapFunctions.predictions != null && GoogleMapFunctions.isList) {
      return Container(
        padding: const EdgeInsets.only(top: 10.0),
        height: 80,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
                GoogleMapFunctions.predictions?.predictions.length??0, (index) {
              return GestureDetector(
                onTap: () async {
                  GoogleMapFunctions.isList = false;

                  await getLatLngFromAddress(GoogleMapFunctions
                      .predictions?.predictions[index].fullText??"");
                  setState(() {});
                },
                child: Container(
                    width: Get.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  //  width: Get.width*0.8,
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        GoogleMapFunctions.predictions?.predictions[index].fullText??"",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    )),
                                Transform.rotate(
                                    angle: 40 * pi / 180,
                                    child: const MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Icon(
                                          Icons.arrow_upward_outlined,
                                          color: Colors.grey,
                                        )))
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        )
                      ],
                    )),
              );
            }),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
