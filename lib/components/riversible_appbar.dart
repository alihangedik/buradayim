import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color.dart';
import '../constant/svg.dart';

Padding riversibleAppbar(
  String title,
  bool iconVisible,
  BuildContext context,
  double top,
  Color? backgroundColor,
  Color? textColor,
) {
  return Padding(
    padding: EdgeInsets.only(top: top),
    child: Wrap(
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 3,
      children: [
        Container(
          height: 60,
          width: 62,
          decoration: BoxDecoration(
              color: AppColor.purple, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                color: AppColor.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: SizedBox(
                width: 30,
                child: SvgPicture.string(
                  AppSvg.buradayimLogo,
                  color: textColor,
                ),
              ),
            ),
            minLeadingWidth: 10,
            contentPadding: EdgeInsets.zero,
            trailing: iconVisible == true
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      size: 40,
                      color: AppColor.white,
                    ))
                : const SizedBox.shrink(),
            tileColor: backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  color: textColor,
                  fontSize: 20),
            ),
          ),
        ),
      ],
    ),
  );
}
