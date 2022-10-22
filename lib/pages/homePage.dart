import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart  ';
import 'package:animated_background/animated_background.dart';
import 'package:login_ui/widgets/drawer.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.cyan,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 70,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );

  final String name="Kshitiz Agarwal";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text("Catalog App"),
      ),
      body:AnimatedBackground(
        // vsync uses singleTicketProvider state mixin.
        vsync: this,
        behaviour: RandomParticleBehaviour(options: particles),

        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    width: 20.0,
                    height: 100.0,
                  ),
                  DefaultTextStyle(
                    style: GoogleFonts.aclonica(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Kshitiz Agarwal',
                          textStyle: GoogleFonts.aladin(
                            color: Colors.amber,
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                      totalRepeatCount: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(
      ),
    );
  }
}