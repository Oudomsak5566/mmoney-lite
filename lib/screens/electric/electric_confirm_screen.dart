// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_lite/providers/electric_provider.dart';
import 'package:mmoney_lite/screens/electric/electric_result_screen.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';

import '../../helper/app_layout.dart';
import '../../helper/random.dart';
import '../../helper/waiting_process.dart';
import '../../providers/user_provider.dart';
import '../../utility/myconstant.dart';
import '../../utility/style.dart';
import '../../widgets/build_background.dart';
import 'package:intl/intl.dart';

import '../../widgets/show_alert.dart';
import 'controllers/electric_url.dart';

class ElectricConfirmScreen extends StatefulWidget {
  const ElectricConfirmScreen({super.key, required this.accNo, required this.accName});

  final String accNo;
  final String accName;

  @override
  State<ElectricConfirmScreen> createState() => _ElectricConfirmScreenState();
}

class _ElectricConfirmScreenState extends State<ElectricConfirmScreen> {
  final _debitAmount = TextEditingController();
  bool isPayment = false;
  int _balanceAmount = 0;

  String _msisdn = "";
  String _name = "";
  String _eWid = "";
  String _code = "";
  String _title = "";
  String _accNo = "";
  String _accName = "";
  String _debit = "";
  String _remark = "";

  void _loadData() async {
    setState(() {
      _msisdn = Provider.of<userProvider>(context, listen: false).walletId.toString();
      _name = Provider.of<userProvider>(context, listen: false).walletName.toString();
      _eWid = Provider.of<electricProvider>(context, listen: false).eWid.toString();
      _code = Provider.of<electricProvider>(context, listen: false).code.toString();
      _title = Provider.of<electricProvider>(context, listen: false).title.toString();
      _accNo = widget.accNo.toString();
      _accName = widget.accName.toString();
      _debit = Provider.of<electricProvider>(context, listen: false).debit.toString();
      _remark = Provider.of<electricProvider>(context, listen: false).remarkNote.toString();
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _debitAmount.text = NumberFormat('#,###').format(
      double.parse(Provider.of<electricProvider>(context, listen: false).debit.toString()),
    );
    if (double.parse(Provider.of<electricProvider>(context, listen: false).debit.toString()) > 0) {
      isPayment = true;
    }
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
                          child: Container(
                            width: AppLayout.getScreenWidth(),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: FormBuilder(
                                // key: _formKey,
                                child: Column(
                                  children: [
                                    buildFromAccount(context),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      child: DottedLine(
                                        lineLength: double.infinity,
                                        lineThickness: 1,
                                        dashLength: 5,
                                        dashColor: Style.dark,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(width: 3, color: Colors.red),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: SvgPicture.asset(Style.imgLogoElec),
                                            ), //Text
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'To',
                                                style: Style.headLineLaoStyle3Black,
                                              ),
                                              Text(
                                                _title,
                                                style: Style.headLineLaoStyle2Black,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('eWID', style: Style.headLineStyle5),
                                              Container(
                                                child: Row(children: [
                                                  Text(_eWid, style: Style.headLineStyle5),
                                                ]),
                                              )
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
                                                _accNo,
                                                style: Style.headLineLaoStyle2Black,
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
                                                _accName,
                                                style: Style.headLineLaoStyle2Black,
                                              ),
                                            ],
                                          ),
                                          //
                                          //
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Debit amount',
                                                  style: Style.headLineLaoStyle3Black,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      NumberFormat('#,###').format(double.parse(
                                                          Provider.of<electricProvider>(context, listen: false)
                                                              .debit
                                                              .toString())),
                                                      style: Style.headLineLaoStyle2Black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              // Text('LAK', style: MyConstant.headLineStyle5),
                                            ],
                                          ),

                                          //
                                          //
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Fee', style: Style.headLineStyle5),
                                              Container(
                                                child: Row(children: [
                                                  Text('0', style: Style.headLineStyle5),
                                                ]),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'PAYMENT AMOUNT',
                                            style: Style.headLineLaoStyle2Black,
                                          ),
                                          Container(
                                            child: Center(
                                              child: FormBuilderTextField(
                                                name: 'debitAmount',
                                                controller: _debitAmount,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none, // labelText: labelName,
                                                  // suffixIcon:
                                                  //     Icon(Icons.edit, color: Colors.grey),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                                onChanged: (val) {},
                                                inputFormatters: [ThousandsFormatter()],
                                                validator: FormBuilderValidators.compose([
                                                  FormBuilderValidators.required(),
                                                  FormBuilderValidators.numeric(),
                                                ]),
                                                // keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                                keyboardType: TextInputType.number,
                                                maxLength: 11,
                                                textInputAction: TextInputAction.next,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 35,
                                                  color: Style.dark,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    const SizedBox(height: 50),
                                    Container(
                                      height: 60,
                                      width: AppLayout.getScreenWidth() * 0.9,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _balanceAmount = Provider.of<userProvider>(context, listen: false).balanceAmount;
                                          print(_balanceAmount);
                                          // double.parse(_debitAmount.text.trim().replaceAll(',', '')
                                          if (_balanceAmount < int.parse(_debitAmount.text.replaceAll(",", ""))) {
                                            showFailedAlert(context, 'Error', 'Your balance not enough.');
                                          } else {
                                            WaitingProcess.show(context);
                                            Future.delayed(MyConstant.delayTime).then((_) {
                                              _paymentProcess();
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Style.dark,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [Text('Confirm ', style: Style.headLineLaoStyle2)],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }

  Padding buildFromAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 3, color: Colors.red),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(3),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(Style.imgLogoCircle),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'From',
                style: Style.headLineLaoStyle3Black,
              ),
              Text(
                context.watch<userProvider>().walletName,
                style: Style.headLineLaoStyle2Black,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wallet ID',
                style: Style.headLineStyle5,
              ),
              Text(
                context.watch<userProvider>().walletId,
                style: Style.headLineStyle5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> _paymentProcess() async {
    double debitAmount = double.parse(_debitAmount.text.trim().replaceAll(',', ''));
    if (debitAmount <= 1000) {
      WaitingProcess.hide(context);
      showFailedAlert(context, 'Error', 'Minimum payment must than 1,000 Kip.');
    } else if (debitAmount > double.parse(Provider.of<electricProvider>(context, listen: false).debit.toString())) {
      WaitingProcess.hide(context);
      showFailedAlert(context, 'Error', 'Payment amount over debit amount.');
    } else {
      var url = '${ElectricConstant.urlAddress}/ePayment';
      var dio = Dio();
      Response response;
      dio.options.connectTimeout = MyConstant.connectTimeout;
      String? tranID = randomNumber().fucRandomNumber();
      try {
        response = await dio.post(
          url,
          data: {
            "TransactionID": tranID,
            "PhoneUser": _msisdn,
            "AccNo": _accNo,
            "AccName": _accName,
            "EWid": _eWid,
            "Amount": _debit,
            "ProCode": _code,
            "Title": _title,
            "Remark": _remark,
          },
          options: Options(
            headers: {'mkey': ElectricConstant.mKey},
          ),
        );
        print('### Response ===> ${response.data}');
        if (response.data['ResultCode'] == "200") {
          WaitingProcess.hide(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ElectricResultScreen(
                        res: response,
                      )));
        } else {
          // WaitingProcess.hide(context);
          showFailedAlert(context, 'Error', response.data['ResultDesc']);
        }
      } on DioError catch (e) {
        print(e.message);
        showFailedAlert(context, 'Error', e.message);
      }
    }
  }
}
