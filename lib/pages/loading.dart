import 'package:buradayim/pages/eartquake_details.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Loading({
    super.key,
    this.depth,
    this.region,
    this.magnitude,
    this.magnitudeType,
    this.time,
    this.latitude,
    this.longitude,
    this.mapImage,
    this.data,
  });

  int? depth;
  String? region;
  var magnitude;
  String? magnitudeType;
  String? time;
  String? longitude;
  String? latitude;
  String? mapImage;
  var data;
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EartquakeDetails()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
