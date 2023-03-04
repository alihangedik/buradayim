import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color.dart';
import '../constant/svg.dart';
import '../pages/number_add.dart';

Padding appbar(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
    child: ListTile(
      minLeadingWidth: 10,
      contentPadding: EdgeInsets.zero,
      trailing: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumberAdd(),
                ));
          },
          icon: const Icon(
            Icons.add_circle_rounded,
            size: 40,
            color: AppColor.white,
          )),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SizedBox(
          width: 30,
          child: SvgPicture.string(
            AppSvg.buradayimLogo,
            color: AppColor.white,
          ),
        ),
      ),
      tileColor: AppColor.purple,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      title: const Text(
        'Buradayım',
        style: TextStyle(
            fontFamily: 'Gilroy-ExtraBold',
            color: AppColor.white,
            fontSize: 20),
      ),
    ),
  );
}
