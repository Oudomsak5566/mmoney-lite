import 'package:flutter/material.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import '../../helper/app_layout.dart';
import '../../utility/style.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Text(
            'History',
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
                            child: Column(
                              children: [],
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
}
