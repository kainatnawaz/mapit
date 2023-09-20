class PickLocationData {
  String? streetAddress;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  double? lat, lng;
  String? geohash;

  String get latString => lat.toString();
  String get lngString => lng.toString();
  PickLocationData(
      {this.streetAddress, this.city, this.state, this.zipCode, this.country, this.lng, this.geohash, this.lat});
}