import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mmoney_lite/screens/login/login_screen.dart';
import 'package:mmoney_lite/utility/myconstant.dart';
import 'package:mmoney_lite/utility/style.dart';
import 'package:quick_actions/quick_actions.dart';

class BeginScreen extends StatefulWidget {
  const BeginScreen({super.key});

  @override
  State<BeginScreen> createState() => _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {
  final List<String> imgList = [
    Style.banner00,
    Style.banner01,
    Style.banner02,
    Style.banner03,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("images/img_ltc.jpg"), fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.3),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(height: 150, width: 150, child: SvgPicture.asset('images/logo_mmoney1.svg')),
                ),
                Text(
                  'LAO MOBILE MONEY',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 80,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Style.dark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(height: 60, width: 60, child: SvgPicture.asset('images/logo_mmoney1.svg')),
                        ),
                        Text(
                          'ເຂົ້າສູ່ລະບົບ',
                          style: Style.headLineLaoStyle2,
                        ),
                        const Spacer(),
                        const Icon(Iconsax.arrow_right_3),
                      ],
                    ),
                  ),
                ),
                buildSliderImage(),
                buildButonBottom(context),
              ],
            ),
          ),
        ));
  }

  Container buildButonBottom(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {},
                child: Glassmorphism(
                  blur: 1,
                  opacity: 0.4,
                  radius: 20,
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.message_text, color: Colors.white),
                        const SizedBox(width: 10),
                        Text('ລົງທະບຽນ', style: Style.headLineLaoStyle4)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {},
                child: Glassmorphism(
                  blur: 1,
                  opacity: 0.4,
                  radius: 20,
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.element_equal, color: Colors.white),
                        const SizedBox(width: 10),
                        Text('ບໍລິການອື່ນໆ', style: Style.headLineLaoStyle4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSliderImage() {
    return Container(
      height: 150,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: imgList.map((item) => Container(child: Image.asset(item, fit: BoxFit.cover, width: double.infinity))).toList(),
      ),
    );
  }
}

class Glassmorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final double radius;
  final Widget child;

  const Glassmorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.radius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
