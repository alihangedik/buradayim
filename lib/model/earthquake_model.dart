class EarthquakeModel {
  String? time;
  var magnitude;
  String? magnitudeType;
  String? latitude;
  String? longitude;
  int? depth;
  String? region;
  String? lastUpdate;
  String? mapImage;

  EarthquakeModel({
    this.time,
    this.magnitude,
    this.magnitudeType,
    this.latitude,
    this.longitude,
    this.depth,
    this.region,
    this.lastUpdate,
    this.mapImage,
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
    mapImage = json['MapImage'];
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
    data['MapImage'] = mapImage;
    data['LastUpdate'] = lastUpdate;
    return data;
  }
}
