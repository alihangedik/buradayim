import 'dart:async';

import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/pages/earthquake.dart';

import 'package:buradayim/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Earthquake(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.purple,
        child: Stack(
          children: [
            Positioned(
                bottom: 40,
                left: 80,
                child: SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            'assets/devnet-logo-white.png',
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 20,
                        color: AppColor.white,
                        thickness: 2,
                      ),
                      Image.asset(
                        'assets/algeware_logo_white.png',
                        scale: 50,
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: -100,
              left: -370,
              child: SvgPicture.string(
                AppSvg.buradayimLogo,
                color: AppColor.white.withOpacity(0.1),
                width: 817,
                height: 681,
              ),
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                height: 168,
                width: 168,
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SvgPicture.string(
                      AppSvg.buradayimLogo,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
