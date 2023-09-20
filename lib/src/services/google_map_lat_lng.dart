

import 'package:mapit/src/services/google_address_model.dart';

class GoogleMapLatLongModel {
  GoogleMapLatLongModel({
    this.plusCode,
    this.results,
    this.status,});

  GoogleMapLatLongModel.fromJson(dynamic json) {
    plusCode = json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }
  PlusCode? plusCode;
  List<Results>? results;
  String? status;
  GoogleMapLatLongModel copyWith({  PlusCode? plusCode,
    List<Results>? results,
    String? status,
  }) => GoogleMapLatLongModel(  plusCode: plusCode ?? this.plusCode,
    results: results ?? this.results,
    status: status ?? this.status,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (plusCode != null) {
      map['plus_code'] = plusCode?.toJson();
    }
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}




class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,});

  PlusCode.fromJson(dynamic json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }
  String? compoundCode;
  String? globalCode;
  PlusCode copyWith({  String? compoundCode,
    String? globalCode,
  }) => PlusCode(  compoundCode: compoundCode ?? this.compoundCode,
    globalCode: globalCode ?? this.globalCode,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['compound_code'] = compoundCode;
    map['global_code'] = globalCode;
    return map;
  }

}