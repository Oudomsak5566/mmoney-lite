import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mmoney_lite/providers/electric_provider.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:provider/provider.dart';

import '../../bottomnav_screen.dart';
import '../../helper/app_layout.dart';
import '../../providers/user_provider.dart';
import '../../utility/myconstant.dart';
import 'package:intl/intl.dart';

import '../../utility/style.dart';

class ElectricResultScreen extends StatelessWidget {
  const ElectricResultScreen({super.key, required this.res});
  final Response res;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Style.imgBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: AppLayout.getScreenWidth(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.15, 0.25, 0.65, 0.8],
                    colors: [Colors.grey.shade300, Colors.grey.shade200, Colors.grey.shade100, Colors.grey.shade300],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const SizedBox(height: 20),
                    buildOperationLogo(),
                    const SizedBox(height: 10),
                    Text(res.data["TransactionID"], style: Style.headLineLaoStyle3Black),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Center(
                              child: Container(
                                // height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                                        child: Container(
                                          width: AppLayout.getScreenWidth(),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey.shade300,
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      '- ${NumberFormat('#,###').format(double.parse(res.data["Amount"]))}',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 32, fontWeight: FontWeight.bold, color: Style.dark),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Fee : ',
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 14, color: Style.dark, fontWeight: FontWeight.w500),
                                                        ),
                                                        Text(
                                                          '0',
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 14, color: Style.dark, fontWeight: FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Divider(color: MyConstant.dark),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'From',
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                          Text(
                                            context.watch<userProvider>().walletName,
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Wallet ID',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            context.watch<userProvider>().walletId,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: buildDotLine(),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'To',
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                          Text(
                                            context.watch<electricProvider>().title,
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Acc ID',
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                          Text(
                                            res.data['AccNo'],
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Acc Name',
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                          Text(
                                            res.data['AccName'],
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Date/Time',
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                          Text(
                                            res.data["CreateDate"],
                                            style: Style.headLineLaoStyle3Black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                            height: 50,
                            width: AppLayout.getScreenWidth() * 0.8,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Navigator.pushReplacement(
                                //     context, MaterialPageRoute(builder: (context) => const BottomNavScreen()));
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (c) => const BottomNavScreen()), (route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Style.dark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Done',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildOperationLogo() {
    return Container(
      child: Column(
        children: [
          Text("PAYMENT", style: Style.headLineStyle1Black),
          SizedBox(
            height: 150,
            child: Lottie.asset('images/lottie/QRpayment.json', repeat: false),
            // child: Image.asset('images/checked.png'),
          ),
          Text(
            "You've successfully transferred money.",
            style: Style.textLaoStyleBlack,
          ),
        ],
      ),
    );
  }

  DottedLine buildDotLine() {
    return DottedLine(lineLength: double.infinity, lineThickness: 1, dashLength: 5, dashColor: Style.dark);
  }
}
