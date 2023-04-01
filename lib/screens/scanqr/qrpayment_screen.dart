// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_lite/helper/random.dart';
import 'package:mmoney_lite/models/qrmerchant_model.dart';
// import 'package:mmoney_lite/screens/scanqr/controllers/scanqr_url.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';

import '../../helper/app_layout.dart';
import '../../helper/waiting_process.dart';
import '../../providers/user_provider.dart';
import '../../utility/myconstant.dart';
import '../../utility/style.dart';
import 'controllers/scanqr_url.dart';

class QrPaymentScreen extends StatefulWidget {
  const QrPaymentScreen({super.key, required this.qrDetail});
  final String qrDetail;

  @override
  State<QrPaymentScreen> createState() => _QrPaymentScreenState();
}

class _QrPaymentScreenState extends State<QrPaymentScreen> {
  // String shopName = "", merchantName = "";
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _tranferAmount = TextEditingController();
  bool canEditAmount = false;
  int _balanceAmount = 0;

  String _QRaccessToken = "";
  String _QRcode = "";
  String _msisdn = "";
  String _transId = "";
  int _paymentAmount = 0;
  // String _transCashOutID = "";
  // String _otpRefCode = "";
  // String _otpRefNo = "";
  // String _apiToken = "";

  QrMerchantModel qrMerchantModel = QrMerchantModel();
  @override
  void initState() {
    super.initState();
    _vertifyQR(widget.qrDetail);
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Text(
            'QR Payment',
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
                                key: _formKey,
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
                                              backgroundImage: AssetImage(Style.imgLogoCircle),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'To',
                                                style: Style.headLineLaoStyle3Black,
                                              ),
                                              Text(
                                                qrMerchantModel.data?.merchantName.toString() ?? '',
                                                style: Style.headLineLaoStyle2Black,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Shop Name',
                                                style: Style.headLineLaoStyle3Black,
                                              ),
                                              Text(
                                                qrMerchantModel.data?.shopName.toString() ?? '',
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
                                                qrMerchantModel.data?.merchantMobile.toString() ?? '',
                                                style: Style.headLineStyle5,
                                              ),
                                            ],
                                          ),
                                          //
                                          //
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Amount',
                                                  style: Style.headLineLaoStyle3Black,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    if (qrMerchantModel.data?.fee != null)
                                                      FormBuilderTextField(
                                                          name: 'transerAmount',
                                                          controller: _tranferAmount,
                                                          readOnly: canEditAmount,
                                                          textAlign: TextAlign.right,
                                                          maxLength: 10,
                                                          decoration: const InputDecoration(counterText: ''),
                                                          onChanged: (val) {},
                                                          inputFormatters: [ThousandsFormatter()],
                                                          validator: FormBuilderValidators.compose([
                                                            FormBuilderValidators.required(),
                                                          ]),
                                                          keyboardType: TextInputType.number,
                                                          textInputAction: TextInputAction.next,
                                                          style: Style.headLineLaoStyle1Red)
                                                    else
                                                      const Text(''),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text('LAK', style: Style.headLineStyle5),
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
                                                  if (qrMerchantModel.data?.fee != null)
                                                    Text(
                                                      NumberFormat('#,###')
                                                          .format(double.parse(qrMerchantModel.data!.fee.toString())),
                                                      style: Style.headLineStyle5,
                                                    )
                                                  else
                                                    const Text(''),
                                                  const SizedBox(width: 10),
                                                  Text('LAK', style: Style.headLineStyle5),
                                                ]),
                                              )
                                            ],
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
                                          _formKey.currentState!.save();
                                          if (_formKey.currentState!.validate()) {
                                            _balanceAmount = Provider.of<userProvider>(context, listen: false).balanceAmount;
                                            print(_balanceAmount);
                                            if (_balanceAmount < int.parse(_tranferAmount.text.replaceAll(",", ""))) {
                                              showErrorWithPopContext('Your balance not enough.').show();
                                            } else {
                                              WaitingProcess.show(context);
                                              Future.delayed(MyConstant.delayTime).then((_) {
                                                _paymentQR();
                                              });
                                            }
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

  Future _vertifyQR(String qrCode) async {
    _QRcode = qrCode;
    _transId = randomNumber().fucRandomNumber();
    print('QRcode ===> ${_QRcode}');

    var dataPost = {"transID": _transId, "qrCode": _QRcode, "type": "UAT"};
    Response response = await Dio().post(
      ScanQrUrl.vertifyQR,
      data: dataPost,
    );
    print('respose VertifyQR ===> ${response.data}');

    qrMerchantModel = QrMerchantModel.fromJson(response.data);
    // print('respose VertifyQR resultCode ===> ${qrMerchantModel.resultCode}');z
    if (qrMerchantModel.resultCode == 0) {
      setState(() {
        qrMerchantModel = qrMerchantModel;
        _tranferAmount.text = NumberFormat('#,###').format(double.parse(qrMerchantModel.data!.transAmount.toString()));
        if (qrMerchantModel.data!.qrType == "dynamic") {
          canEditAmount = true;
        } else {
          _tranferAmount.text = '';
        }
      });
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.topSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.error,
        showCloseIcon: true,
        dismissOnTouchOutside: false,
        btnOkColor: Style.dark,
        title: 'Error',
        titleTextStyle: Style.headLineStyle1Black,
        desc: 'Merchant not found.',
        descTextStyle: GoogleFonts.lato(),
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      ).show();
    }
  }

  Future _paymentQR() async {
    _msisdn = Provider.of<userProvider>(context, listen: false).walletId;
    _paymentAmount = int.parse(_tranferAmount.text.replaceAll(",", ""));
    var dataPost = {"transID": _transId, "qrCode": _QRcode, "type": "UAT", "amount": _paymentAmount};
    //* Confirm QR
    Response response = await Dio().post(
      ScanQrUrl.ConfirmQR,
      data: dataPost,
    );

    print('respose ConfirmQR ===> ${response.data}');

    // if (response.data["responseCode"] == "0000") {
    //   _transCashOutID = response.data["transData"][0]["transCashOutID"];
    //   _otpRefCode = response.data["otpRefCode"];
    //   _otpRefNo = response.data["otpRefNo"];
    //   _apiToken = response.data["apiToken"];
    //   dataPost = {
    //     "apiToken": _apiToken,
    //     "transID": _transId,
    //     "requestorID": PaymentUrl.requestorID,
    //     "transCashOutID": _transCashOutID,
    //     "otpRefNo": _otpRefNo,
    //     "otpRefCode": _otpRefCode,
    //     "otp": ""
    //   };

    //   //* Confirm Cash-Out
    //   response = await Dio().post(
    //     PaymentUrl.confirmOut,
    //     data: dataPost,
    //   );

    //   if (response.data["responseCode"] == "0000") {
    //     dataPost = {
    //       "apiKey": QrUrl.apiKeyConfirmQR,
    //       "apiToken": _QRaccessToken,
    //       "transID": _transId,
    //       "requestorID": QrUrl.requestorID,
    //       "qrCode": _QRcode,
    //       "transAmount": _paymentAmount
    //     };
    //     response = await Dio().post(
    //       QrUrl.confirmQR,
    //       data: dataPost,
    //     );
    //     if (response.data["responseCode"] == "0000") {
    //       print(response);
    //       WaitingProcess.hide(context);
    //       Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => ResultQrPaymentScreen(
    //                     res: response,
    //                   )));
    //     } else {
    //       //! Error Confirm QR-Payment and Refund [Request - Confirm Cash-in]
    //       dataPost = {
    //         "username": PaymentUrl.username,
    //         "password": PaymentUrl.password,
    //         "requestorID": PaymentUrl.requestorID,
    //         "fromAccountOption": "REF",
    //         "fromAccountRef": _msisdn,
    //         "transAmount": _paymentAmount,
    //         "transCurrency": "LAK",
    //         "transRemark": "",
    //         "transRefCol1": "",
    //         "transRefCol2": "",
    //         "transRefCol3": "",
    //         "transRefCol4": "",
    //         "transId": _transId
    //       };
    //       //! Requset Cash-In
    //       response = await Dio().post(
    //         PaymentUrl.requestIn,
    //         data: dataPost,
    //       );
    //       print(response);
    //       if (response.data["responseCode"] == "0000") {
    //         dataPost = {
    //           "apiToken": _apiToken,
    //           "requestorID": PaymentUrl.requestorID,
    //           "transCashInID": response.data["transData"][0]["transCashInID"],
    //           "transID": _transId
    //         };
    //         //! Confirm Cash-In
    //         response = await Dio().post(
    //           PaymentUrl.confirmIn,
    //           data: dataPost,
    //         );
    //         WaitingProcess.hide(context);
    //         showError('Unable to payment process.').show();
    //       } else {
    //         showError(response.data["responseMessage"]).show();
    //       }
    //     }
    //   } else {
    //     //! Error Confirm QR-Payment
    //     showError(response.data["responseMessage"]).show();
    //   }
    // } else {
    //   //! Error Request Cash-Out
    //   showError(response.data["responseMessage"]).show();
    // }
  }

  AwesomeDialog showError(String description) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      btnOkColor: Style.dark,
      title: 'Error',
      titleTextStyle: Style.headLineStyle1Black,
      desc: description,
      descTextStyle: GoogleFonts.lato(),
      btnOkOnPress: () {
        WaitingProcess.hide(context);
      },
    );
  }

  AwesomeDialog showErrorWithPopContext(String description) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      btnOkColor: Style.dark,
      title: 'Error',
      titleTextStyle: Style.headLineStyle1Black,
      desc: description,
      descTextStyle: GoogleFonts.lato(),
      btnOkOnPress: () {
        if (canEditAmount == true) {
          Navigator.pop(context);
        }
      },
    );
  }
}
