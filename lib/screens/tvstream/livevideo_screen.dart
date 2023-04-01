import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:mmoney_lite/utility/myconstant.dart';
import 'package:video_player/video_player.dart';

import '../../helper/app_layout.dart';
import '../../utility/style.dart';
import '../../widgets/build_background.dart';

class LiveVideoScreen extends StatefulWidget {
  @override
  _LiveVideoScreenState createState() => _LiveVideoScreenState();
}

class _LiveVideoScreenState extends State<LiveVideoScreen> {
  late VideoPlayerController controller;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network('http://115.84.121.8:1935/MONO29/MONO29.stream_480p/playlist.m3u8');
    chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chewie = Chewie(
      controller: chewieController,
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Live Video'),
    //   ),
    //   body: Container(child: chewie),
    //   // floatingActionButton: FloatingActionButton(
    //   //   onPressed: () {
    //   //     chewieController.enterFullScreen();
    //   //   },
    //   //   child: Icon(Icons.fullscreen),
    //   // ),
    // );
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Text(
            'TV Online',
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
                              children: [
                                Icon(
                                  Icons.tv,
                                  size: 120,
                                  color: Style.dark,
                                ),
                                Text(
                                  'TV Chanel',
                                  style: Style.headLineLaoStyle1Red,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                                //   child: chewie,
                                // ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: AspectRatio(aspectRatio: controller.value.aspectRatio, child: chewie),
                                ),
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
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
