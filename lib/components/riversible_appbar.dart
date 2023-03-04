import 'package:flutter/material.dart';

import '../constant/color.dart';

Padding riversibleAppbar(
  title,
  iconVisible,
  context,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
    child: Wrap(
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
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
            tileColor: AppColor.purple,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    color: AppColor.white,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
