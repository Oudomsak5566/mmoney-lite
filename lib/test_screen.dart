// import 'package:animation_list/animation_list.dart';
// import 'package:custom_clippers/custom_clippers.dart';
import 'package:animation_list/animation_list.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
// import 'package:custom_clippers/custom_clippers.dart';
// import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> data = [
    {
      'title': '1111',
      'backgroundColor': Colors.grey,
    },
    {
      'title': '2222',
      'backgroundColor': Colors.red,
    },
    {
      'title': '3333',
      'backgroundColor': Colors.yellow,
    },
    {
      'title': '4444',
      'backgroundColor': Colors.blue,
    },
    {
      'title': '5555',
      'backgroundColor': Colors.green,
    },
    {
      'title': '6666',
      'backgroundColor': Colors.orange,
    },
    {
      'title': '7777',
      'backgroundColor': Colors.brown,
    },
    {
      'title': '8888',
      'backgroundColor': Colors.purple,
    },
  ];

  Widget _buildTile(String? title, Color? backgroundColor) {
    return Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: backgroundColor,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimationList(
            duration: 2000,
            reBounceDepth: 10.0,
            children: data.map((item) {
              return _buildTile(item['title'], item['backgroundColor']);
            }).toList()),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'widget.title',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: ClipPath(
//               clipper: TicketPassClipper(position: 80, holeRadius: 40),
//               child: Container(
//                 height: 160,
//                 padding: EdgeInsets.all(20),
//                 color: Colors.red,
//                 alignment: Alignment.center,
//                 child: const Text(
//                   'Multiple Points Clipper Bottom Only',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
