import 'package:buradayim/components/riversible_appbar.dart';
import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NumberAdd extends StatefulWidget {
  const NumberAdd({super.key});

  @override
  State<NumberAdd> createState() => _NumberAddState();
}

class _NumberAddState extends State<NumberAdd> {
  late TextEditingController tfName;
  late TextEditingController tfPhone;
  @override
  void initState() {
    super.initState();
    tfName = TextEditingController();
    tfPhone = TextEditingController();
  }

  List phoneList = [];
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        clipBehavior: Clip.none,
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
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                riversibleAppbar('Numara Ekle', false, context, 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: const [
                      Text(
                        'Numara eklemek için formu doldurun',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Gilroy-Light',
                            color: AppColor.grey),
                      ),
                      Text(
                        '*En fazla 3 numara ekleyebilirsiniz',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Gilroy-Light',
                            color: AppColor.grey),
                      ),
                    ],
                  ),
                ),
                tfWrap(context, Icons.person, 'Telefon Sahibinin Adı', tfName,
                    TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                tfWrap(context, Icons.phone, 'Telefon Numarası', tfPhone,
                    TextInputType.phone),
                FilledButton(
                    onPressed: () {
                      if (phoneList.length < 3) {
                        phoneList.add(tfPhone.text);
                        setState(() {});
                      }
                    },
                    child: const Text('ekle')),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: phoneList.length,
                    itemBuilder: (context, index) {
                      return Text(phoneList[index].toString());
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Wrap tfWrap(BuildContext context, icon, title, controller, type) {
    return Wrap(
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
              icon: Icon(
                icon,
                color: AppColor.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Container(
            height: 60,
            width: 300,
            decoration: BoxDecoration(
                color: AppColor.purple,
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: TextField(
                style: const TextStyle(
                    color: AppColor.white, fontFamily: 'Gilroy'),
                keyboardType: type,
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: title,
                    hintStyle: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        color: AppColor.white.withOpacity(0.5),
                        fontSize: 20)),
              ),
            )),
      ],
    );
  }
}
