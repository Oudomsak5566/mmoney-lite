// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mmoney_lite/models/balance_model.dart';
import 'package:mmoney_lite/models/menu_model.dart';
import 'package:mmoney_lite/screens/login/loginpin_screen.dart';
import 'package:mmoney_lite/splash_screen.dart';
import 'package:mmoney_lite/utility/myconstant.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/dio_service.dart';
import '../../utility/style.dart';
import '../../widgets/build_circleicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isShowBalance = false;
  // String? msisdn = "";
  int? balance;

  late List<MenuModel> _menuModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _data = [
      {
        "id": 1,
        "title": "Bill Payment",
        "menulists": [
          {"menuid": 1, "title": "Electric Du Laos", "route": "/electricprovider", "svgpicture": "images/electric1.svg"},
          {"menuid": 2, "title": "Water Bill", "route": "/", "svgpicture": "images/water.svg"},
          {"menuid": 3, "title": "Telecom Bill", "route": "/", "svgpicture": "images/phone.svg"},
          {"menuid": 4, "title": "Other", "route": "/", "svgpicture": "images/bill.svg"},
        ],
      },
      {
        "id": 2,
        "title": "Mobile Service",
        "menulists": [
          {"menuid": 1, "title": "Mobile Topup", "route": "/", "svgpicture": "images/topup.svg"},
          {"menuid": 2, "title": "Mobile Package", "route": "/", "svgpicture": "images/package.svg"},
        ],
      },
      {
        "id": 3,
        "title": "Insurance",
        "menulists": [
          {"menuid": 1, "title": "AEON", "route": "/", "svgpicture": "images/aeon.svg"},
        ],
      },
      {
        "id": 4,
        "title": "Extension",
        "menulists": [
          {"menuid": 1, "title": "TV-online", "route": "/tvlists", "svgpicture": "images/tv.svg"},
          {"menuid": 2, "title": "TIC TAC TOE", "route": "/", "svgpicture": "images/tictactoe.svg"},
        ],
      }
    ];

    _menuModel = _data.map((i) => MenuModel.fromJson(i)).toList();
    print(_menuModel.length);
    _getBalance();
  }

  Future _getBalance() async {
    BallanceModel balancemodel = BallanceModel();
    String msisdn = Provider.of<userProvider>(context, listen: false).walletId;
    var url = '${MyConstant.urlAddress}/getBalance';
    var data = {"msisdn": msisdn, "type": MyConstant.desRoute};
    var options = {"mlitekey": MyConstant.mlitekey};
    var res = await DioService.createDio(path: url, body: data, option: options);
    if (res["resultCode"] == 0) {
      balancemodel = BallanceModel.fromJson(res);
      setState(() {
        balance = balancemodel.data?.amount;
        context.read<userProvider>().setWalletName(balancemodel.data!.firstname.toString());
        context.read<userProvider>().setBalanceAmount(balance!);
      });
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.topSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.error,
        showCloseIcon: false,
        dismissOnTouchOutside: false,
        btnOkColor: Style.dark,
        title: res["resultCode"],
        titleTextStyle: Style.headLineStyle1Black,
        desc: 'Can\'t get Balance Amount.',
        descTextStyle: GoogleFonts.poppins(),
        btnOkOnPress: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => const SplashScreen()), (route) => false);
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        boxShadow: [BoxShadow(color: Colors.white.withOpacity(.8), blurRadius: 8, spreadRadius: 3)],
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(Style.imgAvatarProfile),
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.watch<userProvider>().walletName,
                            style: Style.headLineLaoStyle2,
                          ),
                          Text(
                            context.watch<userProvider>().walletId,
                            style: Style.headLineLaoStyle4,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      isShowBalance ? '₭ ${NumberFormat('#,###').format(balance)}' : '❈❈❈❈❈❈❈',
                                      style: Style.headLineLaoStyle2,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isShowBalance = isShowBalance ? false : true;
                                      });
                                    },
                                    icon: isShowBalance
                                        ? const Icon(
                                            Iconsax.eye_slash,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Iconsax.eye,
                                            color: Colors.white,
                                          )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _menuModel.length,
                  itemBuilder: (_, index) => Column(
                    children: [
                      buildHeadTypePayment(_menuModel[index].title.toString()),
                      GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 4 / 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(_menuModel[index].menulists!.length, (index1) {
                          return buildCircleIcon(
                              title: _menuModel[index].menulists![index1].title.toString(),
                              svgPicture: _menuModel[index].menulists![index1].svgpicture.toString(),
                              rounteName: _menuModel[index].menulists![index1].route.toString());
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('M-Money Wallet', style: Style.headLineStyle2),
            Spacer(),
            // Icon(Iconsax.scanning),
            // GestureDetector(onTap: () {}, child: Icon(Iconsax.notification, color: Colors.white)),
            // SizedBox(width: 15),
            // GestureDetector(
            //   onTap: () {},
            //   child: Icon(Iconsax.setting_2, color: Colors.white),
            // ),
            // SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPinScreen()));
              },
              child: Row(
                children: [
                  Icon(Iconsax.login, color: Colors.white),
                  SizedBox(width: 3),
                  Text(
                    'Exit',
                    style: Style.textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildHeadTypePayment(String title) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: 5, height: 30, decoration: BoxDecoration(color: Colors.white)),
                SizedBox(width: 10),
                Text(title, style: Style.headLineLaoStyle3),
              ],
            ),
          ),
          Divider(color: Colors.white, thickness: 1, indent: 20, endIndent: 20),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
