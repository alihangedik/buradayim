import 'dart:convert';
import 'dart:developer';

import 'package:buradayim/components/riversible_appbar.dart';
import 'package:buradayim/constant/color.dart';
import 'package:buradayim/constant/svg.dart';
import 'package:buradayim/service/storage_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class NumberAdd extends StatefulWidget {
  NumberAdd({super.key, required this.phoneList});

  var phoneList = [];
  @override
  State<NumberAdd> createState() => _NumberAddState();
}

class _NumberAddState extends State<NumberAdd> {
  StorageService storageService = StorageService();

  late TextEditingController tfName;
  late TextEditingController tfPhone;
  late FocusNode fnName;
  late FocusNode fnPhone;
  @override
  void initState() {
    readData();
    super.initState();
    tfName = TextEditingController();
    tfPhone = TextEditingController();
    fnName = FocusNode();
    fnPhone = FocusNode();
  }

  Future<void> readData() async {
    widget.phoneList = await storageService.readData('phone') ?? [];
    nameList = await storageService.readData('name') ?? [];
  }

  Future<void> saveData() async {
    await storageService.saveData('phone', widget.phoneList.toString());
    await storageService.saveData('name', nameList.toString());
  }

  var nameList = [];
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              riversibleAppbar('Numara Ekle', false, context, 40.0, false),
              textfields(),
              tfWrap(
                context,
                Icons.person,
                'Telefon Sahibinin Adı',
                tfName,
                TextInputType.name,
                [],
                fnName,
              ),
              const SizedBox(
                height: 10,
              ),
              tfWrap(
                context,
                Icons.phone,
                'Telefon Numarası',
                tfPhone,
                TextInputType.phone,
                [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                fnPhone,
              ),
              addButton(),
              const Text(
                'Eklenen Numaralar',
                style: TextStyle(fontFamily: 'Gilroy-Light', fontSize: 20),
              ),
              phoneListtile(context)
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

  SizedBox phoneListtile(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width / 1.1,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.phoneList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 33),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.phoneList.remove(widget.phoneList[index]);
                      nameList.remove(nameList[index]);
                    });
                  },
                  icon: SvgPicture.string(AppSvg.trash)),
              tileColor: AppColor.purple,
              title: Text(
                nameList[index],
                style: const TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 20,
                    color: AppColor.white),
              ),
              subtitle: Text(
                '+9${widget.phoneList[index]}',
                style: const TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 20,
                    color: AppColor.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Container addButton() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: AppColor.transp,
        highlightColor: AppColor.transp,
        onTap: () async {
          RegExp regExp = RegExp(r'^(05(\d{9}))$');
          if (!regExp.hasMatch(tfPhone.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 4),
                backgroundColor: AppColor.purple,
                content: Text(
                  'Lütfen geçerli bir telefon numarası giriniz (05xxxxxxxx)',
                  style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold', color: AppColor.white),
                ),
              ),
            );
            return;
          }

          if (widget.phoneList.length < 3 &&
              tfName.text.isNotEmpty &&
              tfName.text != '' &&
              !widget.phoneList.contains(tfPhone.text)) {
            widget.phoneList.add(tfPhone.text);
            setState(() {});
          }

          if (nameList.length < 3 &&
              tfPhone.text.isNotEmpty &&
              tfPhone.text.length < 12 &&
              !nameList.contains(tfName.text)) {
            nameList.add(tfName.text);
          }
          saveData();
          tfName.text = '';
          tfPhone.text = '';
          fnName.unfocus();
          fnPhone.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.purple,
                borderRadius: BorderRadius.circular(25)),
            width: 114,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Ekle',
                    style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 20,
                        color: AppColor.white),
                  ),
                  Icon(
                    Icons.add_circle,
                    size: 24,
                    color: AppColor.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding textfields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: const [
          Text(
            'Numara eklemek için formu doldurun',
            style: TextStyle(
                fontSize: 16, fontFamily: 'Gilroy-Light', color: AppColor.grey),
          ),
          Text(
            '*En fazla 3 numara ekleyebilirsiniz',
            style: TextStyle(
                fontSize: 12, fontFamily: 'Gilroy-Light', color: AppColor.grey),
          ),
        ],
      ),
    );
  }

  Wrap tfWrap(BuildContext context, icon, title, controller, type,
      List<TextInputFormatter> formatter, focusNode) {
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
              color: AppColor.purple, borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            child: TextFormField(
              focusNode: focusNode,
              style: const TextStyle(
                  color: AppColor.white,
                  fontFamily: 'Gilroy-ExtraBold',
                  fontSize: 20),
              keyboardType: type,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    color: AppColor.white.withOpacity(0.5),
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
