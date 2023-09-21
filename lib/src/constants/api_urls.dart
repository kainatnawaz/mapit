class ApiUrl {

  // GOOGLE MAP API's
  static String getLatLngFromAddress(adress, key) =>
      "https://maps.googleapis.com/maps/api/geocode/json?address=$adress&key=$key";
  static String getAddressFromlatlng(lat, long, key) =>
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$key";
  static String getRouteBetweenCoordinate(latlng1, latlng2, mode, key) =>
      "https://maps.googleapis.com/maps/api/directions/json?origin=${latlng1.latitude},${latlng1.longitude}&destination=${latlng2.latitude},${latlng2.longitude}&mode=$mode&avoidHighways=false&avoidFerries=true&avoidTolls=false&key=$key";
}
