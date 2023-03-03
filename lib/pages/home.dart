import 'package:buradayim/constant/color.dart';

import 'package:flutter/material.dart';

import '../components/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appbar(),
          Center(
            child: InkWell(
              splashColor: AppColor.transp,
              highlightColor: AppColor.transp,
              onTap: () {},
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.purple,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          color: AppColor.black.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 50)
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
