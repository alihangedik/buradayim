import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:background_sms/background_sms.dart';
import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/pages/earthquake.dart';
import 'package:buradayim/pages/success.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/appbar.dart';
import 'number_add.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> phoneList = [];

  void smsPermission() async {
    var status = await Permission.sms.status;

    if (status.isDenied) {
      await Permission.sms.request();
    }

    if (status.isGranted) {
      log('izin alındı');
    } else {
      // İzin verilmediyse, kullanıcıyı uyarmak için bir mesaj gösterin.
      log('SMS izni verilmedi');
    }
  }

  sendSms() async {
    String currentPosition = await currentLocation();
    log('--> ${phoneList[0]}');

    for (var i = 0; i < phoneList.length; i++) {
      SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneList[i],
        message:
            'DİKKAT BU BİR TEST MESAJIDIR!!!.\nEnkaz altındayım lütfen bana yardım edin.\n\nAnlık Lokasyon -->$currentPosition',
      );

      if (result == SmsStatus.sent) {
        log('gonderildi');
      }
    }
  }

  locationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      await Permission.location.request();
    }

    if (status.isGranted) {
      log('konum izni alındı.');
    } else {
      log('konum izni yok');
    }
  }

  Future<String> currentLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    double lat = position.latitude;
    double long = position.longitude;

    List<Placemark> placemark = await placemarkFromCoordinates(lat, long);

    Placemark currentPlacemark = placemark[0];
    String? city = currentPlacemark.locality;
    String? street = currentPlacemark.street;
    String? name = currentPlacemark.name;

    String url = 'https://www.google.com/maps/@$lat$long';

    log(url);
    log(city.toString() + street.toString() + name.toString());
    return url;
  }

  @override
  void initState() {
    super.initState();
    locationPermission();
  }

  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appbar(context, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NumberAdd(
                        phoneList: phoneList,
                      ),
                    ));
              }, true),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: InkWell(
                      splashColor: AppColor.transp,
                      highlightColor: AppColor.transp,
                      onTap: () async {
                        setState(() {
                          isTap = !isTap;
                        });
                        smsPermission();

                        log(phoneList.toString());
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Hayır'),
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColor.purple)),
                                    onPressed: () {
                                      sendSms();

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Success(),
                                          ));
                                    },
                                    child: const Text(
                                      'Evet',
                                      style: TextStyle(color: AppColor.white),
                                    ))
                              ],
                              //Bir daha gösterme seçeneği eklenecek
                              icon: const Icon(
                                Icons.help,
                                size: 31,
                              ),
                              title: const Text('Emin misin?',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold')),
                              content: const Text(
                                'Konumunu göndermek istediğinden emin misin?',
                                style: TextStyle(
                                    fontFamily: 'Gilroy-Light', fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        );
                      },
                      child: AnimatedContainer(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 200),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.purple,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, isTap ? 0 : 10),
                                  color: AppColor.black.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: isTap ? 0 : 50)
                            ]),
                        child: Center(child: SvgPicture.string(AppSvg.send)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Konumu Gönder',
                    style:
                        TextStyle(fontSize: 30, fontFamily: 'Gilroy-ExtraBold'),
                  ),
                  const Text(
                    'Konumunu göndermek için yukarıda ki\nbutona tıkla.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Gilroy-Light',
                        color: AppColor.grey),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(152.0, 'Ayarlar', AppSvg.settings, () {
                      currentLocation();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Home(),
                      //     ));
                    }),
                    button(218.0, 'Son Depremler', AppSvg.pulse, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Earthquake(),
                          ));
                    }),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  InkWell button(width, title, icon, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 56,
        decoration: const BoxDecoration(
            color: AppColor.purple,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.string(
                icon,
                color: AppColor.white,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.white,
                    fontFamily: 'Gilroy-ExtraBold'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
