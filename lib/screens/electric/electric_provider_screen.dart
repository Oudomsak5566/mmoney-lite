import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_lite/providers/electric_provider.dart';
import 'package:mmoney_lite/screens/electric/electric_payment_screen.dart';
import 'package:provider/provider.dart';

import '../../helper/waiting_process.dart';
import '../../utility/myconstant.dart';
import '../../utility/style.dart';
import '../../widgets/build_background.dart';
import 'controllers/electric_model.dart';
import 'controllers/electric_url.dart';

class ElectricProviderScreen extends StatefulWidget {
  const ElectricProviderScreen({super.key});

  @override
  State<ElectricProviderScreen> createState() => _ElectricProviderScreenState();
}

class _ElectricProviderScreenState extends State<ElectricProviderScreen> {
  // กำนหดตัวแปรข้อมูล provider
  late Future<List<providerModel>> providerLists;

  // ตัว ScrollController สำหรับจัดการการ scroll ใน ListView
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    providerLists = _fetchProviderLists();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {
      providerLists = _fetchProviderLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // backgroundColor: Colors.black,
    //   appBar: AppBar(
    //     iconTheme: IconThemeData(color: MyConstant.primary),
    //     backgroundColor: MyConstant.dark,
    //     // title: Text(
    //     //   widget.msisdn ?? 'Null',
    //     //   style: MyConstant().txtHeaderStyle(),
    //     // ),
    //     elevation: 10,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(
    //         bottom: Radius.circular(30),
    //       ),
    //     ),
    //   ),
    // body: SafeArea(
    //   child:
    // ),
    //   bottomNavigationBar: Container(
    //     decoration: const BoxDecoration(color: Colors.transparent),
    //     child: Padding(
    //       padding: const EdgeInsets.only(bottom: 0),
    //       child: SizedBox(
    //           height: 25,
    //           child: Column(
    //             children: [
    //               Text(
    //                 'WebView - Trial Version',
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 12,
    //                 ),
    //               ),
    //             ],
    //           )),
    //     ),
    //   ),
    // );

    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Text(
            'Electric Du Laos',
            style: Style.headLineLaoStyle1,
          ),
        ),
        body: FutureBuilder<List<providerModel>>(
          future: providerLists,
          builder: (context, snapshot) {
            // มีข้อมูล และต้องเป็น done ถึงจะแสดงข้อมูล ถ้าไม่ใช่ ก็แสดงตัว loading
            if (snapshot.hasData) {
              // กำหนดสถานะการแสดง หรือมองเห็น เป็นไม่แสดง
              bool _visible = false;
              // เมื่อกำลังรอข้อมูล
              if (snapshot.connectionState == ConnectionState.waiting) {
                // เปลี่ยนสถานะเป็นแสดง
                _visible = true;
              }
              if (_scrollController.hasClients) {
                //เช็คว่ามีตัว widget ที่ scroll ได้หรือไม่ ถ้ามี
                // เลื่อน scroll มาด้านบนสุด
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              }
              return Column(
                children: [
                  Visibility(
                    visible: _visible,
                    child: const LinearProgressIndicator(),
                  ),
                  Expanded(
                    // ส่วนของลิสรายการ
                    child: snapshot.data!.isNotEmpty // กำหนดเงื่อนไขตรงนี้
                        ? RefreshIndicator(
                            onRefresh: _refresh,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  providerModel providerDetail = snapshot.data![index];
                                  return buildProviderDetail(context, providerDetail);
                                },
                              ),
                            ),
                          )
                        : const Center(
                            child: Text('No items'),
                          ), // กรณีไม่มีรายการ
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              // กรณี error
              return Text('${snapshot.error}');
            }
            // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
            return const Center(child: RefreshProgressIndicator());
          },
        ),
      ),
    );
  }
}

GestureDetector buildProviderDetail(
  BuildContext context,
  providerModel providerDetail,
) {
  return GestureDetector(
    onTap: () {
      WaitingProcess.show(context);
      Future.delayed(MyConstant.delayTime).then((_) {
        // savePreferance("eWid", providerDetail.eWid.toString());
        // savePreferance("code", providerDetail.code.toString());
        // savePreferance("title", providerDetail.title.toString());

        context.read<electricProvider>().setCode(providerDetail.code.toString());
        context.read<electricProvider>().setTitle(providerDetail.title.toString());
        context.read<electricProvider>().setEwid(int.parse(providerDetail.eWid.toString()));
        WaitingProcess.hide(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ElectricPaymentScreen()),
        );
      });
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SvgPicture.asset(
                          Style.imgLogoElec,
                          height: 70.0,
                          width: 50.0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(providerDetail.title.toString(), style: Style.headLineLaoStyle4Black),
                          Text(
                            '${providerDetail.eWid} | ${providerDetail.code} ',
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.navigate_next_rounded,
                    color: Style.primary,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Future<List<providerModel>> _fetchProviderLists() async {
  Dio dio = Dio();
  String url = "${ElectricConstant.urlAddress}/getProvince";
  Response response;
  response = await dio.post(
    url,
    options: Options(
      headers: {
        'mkey': ElectricConstant.mKey,
      },
    ),
  );
  print(response);
  List<providerModel> realdata = response.data.map<providerModel>((json) => providerModel.fromJson(json)).toList();
  return realdata;
}
