import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/pages/earthquake.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          appbar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  splashColor: AppColor.transp,
                  highlightColor: AppColor.transp,
                  onTap: () {
                    setState(() {
                      isTap = !isTap;
                    });
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
                              color: AppColor.black.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: isTap ? 0 : 50)
                        ]),
                    child: Center(child: SvgPicture.string(AppSvg.send)),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Konumumu Gönder',
                style: TextStyle(fontSize: 30, fontFamily: 'Gilroy-ExtraBold'),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        // ignore: prefer_const_constructors
                        builder: (context) => Home(),
                      ));
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
