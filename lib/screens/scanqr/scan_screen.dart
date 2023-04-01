
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmoney_lite/helper/app_layout.dart';
import 'package:mmoney_lite/screens/scanqr/qrpayment_screen.dart';
import 'package:mmoney_lite/utility/myconstant.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../helper/waiting_process.dart';
import '../../utility/style.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool scanned = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
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
            'Scan QRcode',
            style: Style.headLineLaoStyle1,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildQrView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
// For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 300.0 : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white, borderRadius: 20, borderLength: 20, borderWidth: 10, cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!scanned) {
        scanned = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrPaymentScreen(
              qrDetail: scanData.code.toString(),
            ),
          ),
        ).then((value) => scanned = false);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
