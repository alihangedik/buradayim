import 'package:buradayim/components/appbar.dart';
import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/pages/home.dart';
import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appbar(context, null, false),
          Center(
            child: SvgPicture.string(AppSvg.success),
          ),
          const Text(
            'Konumunu Gönderdik',
            style: TextStyle(fontSize: 30, fontFamily: 'Gilroy-ExtraBold'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: SizedBox(
              width: 270,
              height: 60,
              child: CupertinoButton(
                color: AppColor.purple,
                borderRadius: BorderRadius.circular(25),
                child: Text(
                  'Ana Sayfaya Dön',
                  style:
                      TextStyle(fontFamily: 'Gilroy-ExtraBold', fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                      (route) => false);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
