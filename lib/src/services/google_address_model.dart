class GoogleAddressModel {
  GoogleAddressModel({
    this.results,
    this.status,});

  GoogleAddressModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Results>? results;
  String? status;
  GoogleAddressModel copyWith({  List<Results>? results,
    String? status,
  }) => GoogleAddressModel(  results: results ?? this.results,
    status: status ?? this.status,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}

class Results {
  Results({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.partialMatch,
    this.placeId,
    this.types,});

  Results.fromJson(dynamic json) {
    if (json['address_components'] != null) {
      addressComponents = [];
      json['address_components'].forEach((v) {
        addressComponents?.add(AddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    partialMatch = json['partial_match'];
    placeId = json['place_id'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  bool? partialMatch;
  String? placeId;
  List<String>? types;
  Results copyWith({  List<AddressComponents>? addressComponents,
    String? formattedAddress,
    Geometry? geometry,
    bool? partialMatch,
    String? placeId,
    List<String>? types,
  }) => Results(  addressComponents: addressComponents ?? this.addressComponents,
    formattedAddress: formattedAddress ?? this.formattedAddress,
    geometry: geometry ?? this.geometry,
    partialMatch: partialMatch ?? this.partialMatch,
    placeId: placeId ?? this.placeId,
    types: types ?? this.types,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressComponents != null) {
      map['address_components'] = addressComponents?.map((v) => v.toJson()).toList();
    }
    map['formatted_address'] = formattedAddress;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    map['partial_match'] = partialMatch;
    map['place_id'] = placeId;
    map['types'] = types;
    return map;
  }

}

class Geometry {
  Geometry({
    this.bounds,
    this.location,
    this.locationType,
    this.viewport,});

  Geometry.fromJson(dynamic json) {
    bounds = json['bounds'] != null ? Bounds.fromJson(json['bounds']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }
  Bounds? bounds;
  Location? location;
  String? locationType;
  Viewport? viewport;
  Geometry copyWith({  Bounds? bounds,
    Location? location,
    String? locationType,
    Viewport? viewport,
  }) => Geometry(  bounds: bounds ?? this.bounds,
    location: location ?? this.location,
    locationType: locationType ?? this.locationType,
    viewport: viewport ?? this.viewport,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bounds != null) {
      map['bounds'] = bounds?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['location_type'] = locationType;
    if (viewport != null) {
      map['viewport'] = viewport?.toJson();
    }
    return map;
  }

}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,});

  Viewport.fromJson(dynamic json) {
    northeast = json['northeast'] != null ? Northeast.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? Southwest.fromJson(json['southwest']) : null;
  }
  Northeast? northeast;
  Southwest? southwest;
  Viewport copyWith({  Northeast? northeast,
    Southwest? southwest,
  }) => Viewport(  northeast: northeast ?? this.northeast,
    southwest: southwest ?? this.southwest,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (northeast != null) {
      map['northeast'] = northeast?.toJson();
    }
    if (southwest != null) {
      map['southwest'] = southwest?.toJson();
    }
    return map;
  }

}

class Southwest {
  Southwest({
    this.lat,
    this.lng,});

  Southwest.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  num? lat;
  num? lng;
  Southwest copyWith({  num? lat,
    num? lng,
  }) => Southwest(  lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

}

class Northeast {
  Northeast({
    this.lat,
    this.lng,});

  Northeast.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  num? lat;
  num? lng;
  Northeast copyWith({  num? lat,
    num? lng,
  }) => Northeast(  lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

}

class Location {
  Location({
    this.lat,
    this.lng,});

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  num? lat;
  num? lng;
  Location copyWith({  num? lat,
    num? lng,
  }) => Location(  lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,});

  Bounds.fromJson(dynamic json) {
    northeast = json['northeast'] != null ? Northeast.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? Southwest.fromJson(json['southwest']) : null;
  }
  Northeast? northeast;
  Southwest? southwest;
  Bounds copyWith({  Northeast? northeast,
    Southwest? southwest,
  }) => Bounds(  northeast: northeast ?? this.northeast,
    southwest: southwest ?? this.southwest,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (northeast != null) {
      map['northeast'] = northeast?.toJson();
    }
    if (southwest != null) {
      map['southwest'] = southwest?.toJson();
    }
    return map;
  }

}



class AddressComponents {
  AddressComponents({
    this.longName,
    this.shortName,
    this.types,});

  AddressComponents.fromJson(dynamic json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  String? longName;
  String? shortName;
  List<String>? types;
  AddressComponents copyWith({  String? longName,
    String? shortName,
    List<String>? types,
  }) => AddressComponents(  longName: longName ?? this.longName,
    shortName: shortName ?? this.shortName,
    types: types ?? this.types,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['long_name'] = longName;
    map['short_name'] = shortName;
    map['types'] = types;
    return map;
  }

}