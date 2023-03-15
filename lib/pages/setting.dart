import 'package:buradayim/components/riversible_appbar.dart';
import 'package:buradayim/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/svg.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

late TextEditingController tfName;

class _SettingsState extends State<Settings> {
  String? name = 'İsim Ekle';
  IconData icon = Icons.help;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tfName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Column(children: [
          riversibleAppbar('Ayarlar', false, context, 40.0, false),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              _settingListtile(
                name!.isEmpty ? 'İsim Ekle' : name!,
                'Gilroy-ExtraBold',
                icon,
                () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      elevation: 0,
                      title: const Center(
                        child: Text(
                          'Lütfen adını aşağıya gir.',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      content: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 62,
                                  decoration: BoxDecoration(
                                      color: AppColor.purple,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.person,
                                        color: AppColor.white,
                                        size: 35,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 60,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: AppColor.purple,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: TextFormField(
                                      controller: tfName,
                                      style: const TextStyle(
                                          color: AppColor.white,
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Adın, Soyadın',
                                        hintStyle: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            color:
                                                AppColor.white.withOpacity(0.5),
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            addButton(context),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              _settingListtile(
                  'Bu uygulama neden var?', 'Gilroy-ExtraBold', Icons.help, () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text(
                          'Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500\'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960\'larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Gilroy-Light'),
                        ),
                        title: const Center(
                          child: Text(
                            'Bu uygulama neden var?',
                            style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold', fontSize: 15),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Kapat',
                              style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold', fontSize: 15),
                            ),
                          )
                        ],
                      );
                    });
              }),
              _settingListtile(
                  'Uygulama versiyonu v1.0', 'Gilroy-Light', null, null),
            ],
          ),
        ])),
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

  Container addButton(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: AppColor.transp,
        highlightColor: AppColor.transp,
        onTap: () {
          setState(() {
            name = tfName.text.toString();
            if (name!.isNotEmpty) {
              icon = Icons.edit;
            } else {
              icon = Icons.add_circle;
            }
            Navigator.pop(context);
          });
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

  Padding _settingListtile(
      String title, font, IconData? icon, Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        trailing: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            size: 30,
            color: AppColor.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(title,
              style: TextStyle(
                  fontFamily: font, fontSize: 20, color: AppColor.white)),
        ),
        tileColor: AppColor.purple,
      ),
    );
  }
}
