// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_lite/providers/electric_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/app_layout.dart';
import '../../helper/waiting_process.dart';
import '../../providers/user_provider.dart';
import '../../utility/myconstant.dart';
import '../../utility/style.dart';
import '../../widgets/build_background.dart';
import '../../widgets/build_textfiled.dart';
import '../../widgets/show_alert.dart';
import 'controllers/electric_recent_model.dart';
import 'controllers/electric_url.dart';
import 'electric_confirm_screen.dart';

class ElectricPaymentScreen extends StatefulWidget {
  const ElectricPaymentScreen({super.key});

  @override
  State<ElectricPaymentScreen> createState() => _ElectricPaymentScreenState();
}

class _ElectricPaymentScreenState extends State<ElectricPaymentScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _accoutNumber = TextEditingController();
  final _note = TextEditingController();
  late Future<List<ElectricRecentAccModel>> recentLists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentLists = _fetchRecentAcc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Text(
            'Electric Payment',
            style: Style.headLineLaoStyle1,
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: AppLayout.getScreenWidth(),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                buildHeader(),
                                buildForm(),
                                Expanded(
                                  child: FutureBuilder(
                                    future: recentLists,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20, top: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '# Recent Account Number',
                                                    style: GoogleFonts.poppins(textStyle: Style.headLineStyle3Black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Expanded(child: Text('data'))
                                            SizedBox(
                                              height: 300,
                                              child: ListView.separated(
                                                itemCount: snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  ElectricRecentAccModel recentModel = snapshot.data![index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      WaitingProcess.show(context);
                                                      Future.delayed(MyConstant.delayTime).then((_) {
                                                        getDebitProcess(recentModel.accNo.toString());
                                                      });
                                                    },
                                                    child: ListTile(
                                                      leading: Icon(Icons.account_circle_rounded, color: Style.dark, size: 50),
                                                      // title: Container() Text(recentModel.accNo.toString()),
                                                      title: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            recentModel.accNo.toString(),
                                                            style: GoogleFonts.roboto(textStyle: Style.headLineLaoStyle3Black),
                                                          ),
                                                          Text(
                                                            recentModel.accName.toString().replaceAll('AccName :', ''),
                                                            style: GoogleFonts.notoSansLao(textStyle: Style.textLaoStyleBlack),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Icon(
                                                        Icons.navigate_next_rounded,
                                                        color: Style.primary,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (context, index) {
                                                  return const Divider();
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        // กรณี error
                                        return Text('${snapshot.error}');
                                      }
                                      return const Center(child: RefreshProgressIndicator());
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  WaitingProcess.show(context);
                  Future.delayed(MyConstant.delayTime).then((_) {
                    getDebitProcess(_accoutNumber.text.trim());
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Style.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Confirm',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        //
      ),
    );
  }

  FormBuilder buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          buildTextfield(
            size: AppLayout.getScreenWidth(),
            labelName: 'Account Number',
            controllerName: _accoutNumber,
            nameTextfield: 'accountNumber',
            // icons: Icons.border_color_rounded,
            icons: Icons.draw_rounded,
            isRequire: true,
          ),
          buildTextfield(
            size: AppLayout.getScreenWidth(),
            labelName: 'Note',
            controllerName: _note,
            nameTextfield: 'note',
            icons: Icons.note_add_rounded,
            isRequire: false,
          ),
        ],
      ),
    );
  }

  Row buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SvgPicture.asset(
                  Style.imgLogoElec,
                  height: 120.0,
                  width: 120.0,
                ),
              ),
              Text(
                // 'providerName',
                Provider.of<electricProvider>(context, listen: false).title.toString(),
                style: GoogleFonts.notoSansLao(textStyle: Style.headLineLaoStyle2Black),
              ),
              Text(
                '${Provider.of<electricProvider>(context, listen: false).eWid.toString()} | ${Provider.of<electricProvider>(context, listen: false).code.toString()}',
                style: GoogleFonts.poppins(textStyle: Style.headLineLaoStyle4Black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<List<ElectricRecentAccModel>> _fetchRecentAcc() async {
    Dio dio = Dio();
    String url = "${ElectricConstant.urlAddress}/getRecent";
    Response response;
    String msisdn = Provider.of<userProvider>(context, listen: false).walletId;
    // print(widget.msisdn);
    response = await dio.post(
      url,
      options: Options(
        headers: {
          'mkey': ElectricConstant.mKey,
        },
      ),
      data: {
        "Msisdn": msisdn,
      },
    );
    print(response);
    List<ElectricRecentAccModel> realdata =
        response.data.map<ElectricRecentAccModel>((json) => ElectricRecentAccModel.fromJson(json)).toList();
    return realdata;
  }

  Future<Null> getDebitProcess(String accNo) async {
    var remarkNote = _note.text.trim();
    var url = '${ElectricConstant.urlAddress}/getDebit';
    String msisdn = Provider.of<userProvider>(context, listen: false).walletId;
    int eWid = Provider.of<electricProvider>(context, listen: false).eWid;
    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        url,
        data: {"TransactionID": "", "PhoneUser": msisdn, "AccNo": accNo, "EWid": eWid, "Remark": remarkNote},
        options: Options(
          headers: {
            'mkey': ElectricConstant.mKey,
          },
        ),
      );

      print('### get Debit  ===> ${response.data}');
      if (response.data['ResultCode'] == "200") {
        context.read<electricProvider>().setDebit(int.parse(response.data['Debit']));
        context.read<electricProvider>().setRemarkNote(remarkNote);
        WaitingProcess.hide(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ElectricConfirmScreen(
                    accNo: accNo,
                    accName: response.data['AccName'],
                  )),
        );
      } else {
        WaitingProcess.hide(context);
        showFailedAlert(context, 'Error', response.data['ResultDesc']);
      }
    } on DioError catch (e) {
      WaitingProcess.hide(context);
      print(e.message);
      showFailedAlert(context, 'Error', e.message);
    }
  }
}
