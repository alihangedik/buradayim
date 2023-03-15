import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:buradayim/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColor.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appbar(context, null, false),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: SvgPicture.string(AppSvg.success),
                  ),
                  Column(
                    children: const [
                      Text(
                        'Konumunu Gönderdik',
                        style: TextStyle(
                            fontSize: 30, fontFamily: 'Gilroy-ExtraBold'),
                      ),
                      Text(
                        'Sana en yakın zamanda \nulaşılması için konumunu \nve enkaz altında olduğun \nbilgisini paylaştık ',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 22, fontFamily: 'Gilroy-Light'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80.0),
                    child: SizedBox(
                      width: 270,
                      height: 60,
                      child: CupertinoButton(
                        color: AppColor.purple,
                        borderRadius: BorderRadius.circular(25),
                        child: const Text(
                          'Ana Sayfaya Dön',
                          style: TextStyle(
                              fontFamily: 'Gilroy-ExtraBold', fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: -100,
          right: -170,
          child: SvgPicture.string(
            AppSvg.buradayimLogo,
            color: AppColor.purple.withOpacity(0.2),
            height: 514,
          ),
        ),
      ],
    );
  }
}
