import 'dart:async';

import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/model/earthquake_model.dart';
import 'package:buradayim/service/earthquake_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/riversible_appbar.dart';

class Earthquake extends StatefulWidget {
  const Earthquake({super.key});

  @override
  State<Earthquake> createState() => _EarthquakeState();
}

class _EarthquakeState extends State<Earthquake> {
  late Future<List<EarthquakeModel>> model;
  List data = [];
  @override
  void initState() {
    super.initState();
    model = EarthquakeService().fetchData();
  }

  Future<void> _refresh() async {
    await EarthquakeService().fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          riversibleAppbar('Son Depremler', false, context),
          infoText(),
          futureBuilder(context)
        ],
      ),
    );
  }

  Padding infoText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '*Veriler Kandilli Rasathanesinden Alınmıştır',
        style: TextStyle(fontSize: 12, fontFamily: 'Gilroy-Light'),
      ),
    );
  }

  SizedBox futureBuilder(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.188,
      child: FutureBuilder(
          future: model,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;

              return RefreshIndicator(
                onRefresh: _refresh,
                child: earthquakeList(data),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  ListView earthquakeList(List<EarthquakeModel> data) {
    return ListView.builder(
      itemCount: 15,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            color: AppColor.purple,
            child: SizedBox(
                height: 200,
                width: 391,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: -20,
                          right: -20,
                          child: SvgPicture.string(
                            AppSvg.buradayimLogo,
                            height: 130,
                            color: AppColor.white,
                          )),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  data[index].region.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      color: AppColor.white,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30.0, top: 0),
                                child: Row(
                                  children: [
                                    Text(
                                      data[index].magnitude.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          color: AppColor.white,
                                          fontSize: 34),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        data[index].magnitudeType.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            color: AppColor.white,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          cardInformations(data[index].time, AppSvg.time),
                          cardInformations(data[index].depth.toString() + ' km',
                              AppSvg.arrow),
                          cardInformations(
                              data[index]
                                      .longitude
                                      .toString()
                                      .replaceAll('&deg; E', '') +
                                  ' , ' +
                                  data[index]
                                      .latitude
                                      .toString()
                                      .replaceAll('&deg; N', ''),
                              AppSvg.depth),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  Padding cardInformations(title, icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SvgPicture.string(icon),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  color: AppColor.white,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
