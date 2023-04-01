import 'package:flutter/material.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utility/myconstant.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: WebviewScreen(),
//     ),
//   );
// }

// class WebviewScreen extends StatefulWidget {
//   const WebviewScreen({super.key});

//   @override
//   State<WebviewScreen> createState() => _WebviewScreenState();
// }

// class _WebviewScreenState extends State<WebviewScreen> {
//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   late final WebViewController controller;
//   // String url = 'https://youtube.com';
//   String url = 'http://172.28.12.204:7000';
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse(url),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return buildBackground(
//       widget: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black.withOpacity(0),
//           elevation: 0,
//           title: Text(
//             'M-Games',
//             style: MyConstant.headLineLaoStyle1,
//           ),
//         ),
//         body: WebViewWidget(
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utility/style.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  var loadingPercentage = 0;
  late final WebViewController controller;
  String url = 'http://172.28.12.204:7000';
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Text(
            'M-Games',
            style: Style.headLineLaoStyle1,
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ),
      ),
    );
  }
}
