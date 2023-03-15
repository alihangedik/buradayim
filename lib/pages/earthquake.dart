import 'dart:async';

import 'package:buradayim/components/date_format.dart';
import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/model/earthquake_model.dart';
import 'package:buradayim/pages/eartquake_details.dart';
import 'package:buradayim/service/earthquake_service.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../components/riversible_appbar.dart';

class Earthquake extends StatefulWidget {
  const Earthquake({super.key});

  @override
  State<Earthquake> createState() => _EarthquakeState();
}

class _EarthquakeState extends State<Earthquake> {
  late Future<List<EarthquakeModel>?> model;
  final Connectivity connectivity = Connectivity();
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> streamSubscription;

  Future<void> updateStatus(ConnectivityResult result) async {
    connectivityResult = result;

    setState(() {});
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {}
    return updateStatus(result);
  }

  @override
  void initState() {
    super.initState();
    model = EarthquakeService().fetchData();
    initConnectivity();
    streamSubscription =
        connectivity.onConnectivityChanged.listen(updateStatus);
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
          riversibleAppbar('Son Depremler', false, context, 40.0, false),
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
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            var data = snapshot.data;

            return RefreshIndicator(
              onRefresh: _refresh,
              child: data == null
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : earthquakeList(data),
            );
          }
          return notFoundInternet();
        },
      ),
    );
  }

  Wrap notFoundInternet() {
    return Wrap(
      runSpacing: 50,
      runAlignment: WrapAlignment.center,
      children: [
        Center(
          child: SvgPicture.string(AppSvg.notConnection),
        ),
        Column(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Center(
                child: Text(
                  'İnternet bağlantısı bulunamadı!',
                  style:
                      TextStyle(fontFamily: 'Gilroy-ExtraBold', fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  'Şuan da internete bağlı değilsiniz. Lütfen bağlantınızı kontrol edip tekrar deneyin.',
                  style: TextStyle(fontFamily: 'Gilroy-Light', fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  ListView earthquakeList(List<EarthquakeModel> data) {
    return ListView.builder(
      itemCount: 15,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var magnitude = data[index].magnitude.toString();

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EartquakeDetails(
                        depth: data[index].depth,
                        region: data[index].region,
                        time: data[index].time,
                        magnitude: data[index].magnitude,
                        magnitudeType: data[index].magnitudeType,
                        latitude: data[index].latitude,
                        longitude: data[index].longitude,
                        mapImage: data[index].mapImage,
                        data: data[index]),
                  ));
            },
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
                                  child: SizedBox(
                                    width: 220,
                                    child: Text(
                                      data[index]
                                          .region
                                          .toString()
                                          .replaceAll('-', ' , '),
                                      style: const TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          color: AppColor.white,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 30.0, top: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        magnitude.length == 1
                                            ? '$magnitude.0'
                                            : magnitude,
                                        style: const TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            color: AppColor.white,
                                            fontSize: 34),
                                      ),
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(top: 14.0),
                                      //   child: Text(
                                      //     data[index].magnitudeType.toString(),
                                      //     style: const TextStyle(
                                      //         fontFamily: 'Gilroy-ExtraBold',
                                      //         color: AppColor.white,
                                      //         fontSize: 12),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            cardInformations(
                                TurkishDateFormat.turkishDatewithTime(
                                    DateTime.parse(data[index]
                                        .time
                                        .toString()
                                        .replaceAll('/', '-'))),
                                AppSvg.time),
                            cardInformations(
                              '${data[index].depth} km',
                              AppSvg.arrow,
                            ),
                            cardInformations(
                              '${data[index].latitude.toString().replaceAll('&deg;', '°')} , ${data[index].longitude.toString().replaceAll('&deg;', '°')}',
                              AppSvg.depth,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
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
          SizedBox(
            width: 20,
            child: SvgPicture.string(icon),
          ),
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
