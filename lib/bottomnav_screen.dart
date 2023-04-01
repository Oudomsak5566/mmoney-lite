import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mmoney_lite/screens/history/history_screen.dart';
import 'package:mmoney_lite/screens/home/home_screen.dart';
import 'package:mmoney_lite/screens/scanqr/scan_screen.dart';
import 'package:mmoney_lite/screens/webview/webview_screen.dart';
import 'package:mmoney_lite/utility/style.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int visit = 0;
  double height = 30;
  Color colorSelect = Style.light;
  Color color = Style.light;
  Color color2 = Style.dark;
  Color bgColor = Style.light;
  List pages = [
    const HomeScreen(),
    // const HomeScreen(),
    const ScanScreen(),
    const WebviewScreen(),
    const HistoryScreen(),
  ];
  List<TabItem> items = [
    const TabItem(
      icon: Iconsax.home_15,
      title: 'Home',
    ),
    // const TabItem(
    //   icon: Iconsax.scanning,
    //   title: 'MyQR',
    // ),
    const TabItem(
      icon: Iconsax.scanner,
      title: 'Scan QR',
    ),
    const TabItem(
      icon: Iconsax.game,
      title: 'M-Games',
    ),
    const TabItem(
      icon: Iconsax.document_text,
      title: 'History',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[visit],
      bottomNavigationBar: BottomBarDivider(
        items: items,
        titleStyle: Style.textStyle,
        blur: 10,
        backgroundColor: Style.dark.withOpacity(0.9),
        color: Colors.grey.shade400,
        colorSelected: Colors.white,
        indexSelected: visit,
        styleDivider: StyleDivider.top,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
