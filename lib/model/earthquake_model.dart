class EarthquakeModel {
  String? time;
  var magnitude;
  String? magnitudeType;
  String? latitude;
  String? longitude;
  int? depth;
  String? region;
  String? lastUpdate;

  EarthquakeModel({
    this.time,
    this.magnitude,
    this.magnitudeType,
    this.latitude,
    this.longitude,
    this.depth,
    this.region,
    this.lastUpdate,
  });

  EarthquakeModel.fromJson(Map json) {
    time = json['Time'];
    magnitude = json['Magnitude'];
    magnitudeType = json['MagnitudeType'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    depth = json['Depth'];
    region = json['Region'];
    lastUpdate = json['LastUpdate'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};

    data['Time'] = time;
    data['Magnitude'] = magnitude;
    data['MagnitudeType'] = magnitudeType;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Depth'] = depth;
    data['Region'] = region;

    data['LastUpdate'] = lastUpdate;
    return data;
  }
}
