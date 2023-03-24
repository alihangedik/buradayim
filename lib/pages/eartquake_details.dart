import 'dart:async';
import 'dart:developer';
import 'package:buradayim/components/date_format.dart';
import 'package:buradayim/components/riversible_appbar.dart';
import 'package:buradayim/constant/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/svg.dart';

class EartquakeDetails extends StatefulWidget {
  EartquakeDetails({
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
  State<EartquakeDetails> createState() => _EartquakeDetailsState();
}

class _EartquakeDetailsState extends State<EartquakeDetails> {
  Future<void> goLocation(String location) async {
    if (await canLaunch(location)) {
      await launch(location);
    } else {
      _showAlertDialog();
    }
  }

  Future<dynamic> _showAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        title: const Center(
            child: Icon(Icons.warning_rounded, color: AppColor.grey, size: 35)),
        content: const Text(
          'Konuma gitmek için harita uygulaması bulunamadı.',
          style: TextStyle(fontFamily: 'Gilroy-ExtraBold'),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Kapat',
              style: TextStyle(fontFamily: 'Gilroy-ExtraBold'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Stack(
        children: [
          Positioned(
            bottom: -100,
            right: -170,
            child: SvgPicture.string(
              AppSvg.buradayimLogo,
              color: AppColor.purple.withOpacity(0.2),
              height: 514,
            ),
          ),
          Scaffold(
            backgroundColor: AppColor.transp,
            body: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: riversibleAppbar('Son Depremler', false, context,
                          40.0, AppColor.white, AppColor.purple),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: detailsContainer(),
                    ),
                    detailsList(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.9,
                      height: MediaQuery.of(context).size.height / 16,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.purple),
                        ),
                        child: const Text(
                          'Konuma Git',
                          style: TextStyle(
                              fontFamily: 'Gilroy-ExtraBold',
                              fontSize: 20,
                              color: AppColor.white),
                        ),
                        onPressed: () {
                          var latitude = widget.latitude
                              .toString()
                              .replaceAll('&deg; N', '');
                          var longitude = widget.longitude
                              .toString()
                              .replaceAll('&deg; E', '');
                          goLocation(
                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //         'Konum: ${widget.latitude}, ${widget.longitude}'),
                          //   ),
                          // );
                          log('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding detailsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 30),
      child: ListView(
        shrinkWrap: true,
        children: [
          detailsListtile(AppSvg.arrow, 'Derinlik', '${widget.depth} km'),
          detailsListtile(
            AppSvg.time,
            'Zaman',
            TurkishDateFormat.turkishOnlyDaywithTime(
              DateTime.parse(
                widget.time.toString().replaceAll('/', '-'),
              ),
            ),
          ),
          detailsListtile(
            AppSvg.depth,
            'Latitude',
            widget.latitude.toString().replaceAll('&deg;', '°'),
          ),
          detailsListtile(
            AppSvg.depth,
            'Longitude',
            widget.longitude.toString().replaceAll('&deg;', '°'),
          ),
        ],
      ),
    );
  }

  Column detailsContainer() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: AppColor.purple,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          height: 209,
          width: 322,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.magnitude.toString().length == 1
                        ? '${widget.magnitude}.0'
                        : widget.magnitude.toString(),
                    style: const TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        color: AppColor.white,
                        fontSize: 79),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0, left: 5),
                    child: Text(
                      widget.magnitudeType.toString(),
                      style: const TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          color: AppColor.white,
                          fontSize: 27),
                    ),
                  )
                ],
              ),
              Container(
                child: Text(
                  widget.region.toString().replaceAll('-', ',  '),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      color: AppColor.white,
                      fontSize: 27),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }

  ListTile detailsListtile(icon, title, data) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      leading: SvgPicture.string(
        icon,
        width: 25,
        color: AppColor.purple,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'Gilroy-ExtraBold',
            fontSize: 25,
            color: AppColor.purple),
      ),
      trailing: Text(
        data,
        style: const TextStyle(
            fontFamily: 'Gilroy-ExtraBold',
            fontSize: 25,
            color: AppColor.purple),
      ),
    );
  }
}
