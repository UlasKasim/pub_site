import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pub_site/controllers/character_controller.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'animations/fade_animation.dart';
import 'helper/page_change_helper.dart';
import 'pages/roster.dart';
// import 'form.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  CharacterController characterController = Get.put(CharacterController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pub Guild',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHover = false;
  bool isArselShow = false;
  TextStyle style(double fontSize,
      {String fontFamily = "Poppins", double letterSpacing, Color color, FontWeight fontWeight}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color ?? Color(0xFF222835),
      fontWeight: fontWeight ?? FontWeight.bold,
      letterSpacing: letterSpacing ?? 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0),
            child: ListView(
              children: [
                FadeAnimation(
                  delay: 400,
                  child: Container(
                    color: Colors.green.withOpacity(0.2),
                    child: Column(
                      children: [
                        // Text("pub", style: style(28, letterSpacing: 0.2)),
                        Image.asset(
                          "images/publogo.png",
                          height: 40,
                          width: 60,
                        ),
                        Text(
                          "EU - SILVERMOON",
                          style: style(8, letterSpacing: 1.8),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                  delay: 500,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      "images/shadowlands.png",
                      height: 75,
                      width: 177,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FadeAnimation(
                  delay: 800,
                  child: Column(
                    children: [
                      paragraphText(
                          "Selam! Burası Pub. Burda dünyayı kurtarmıyoruz, world rank icin yarışmıyoruz. Bi' avuç arkadaş beraber oyun oynuyoruz."),
                      SizedBox(
                        height: 30,
                      ),
                      paragraphText(
                          "Raid yapmayi seviyoruz ve mythic zorlukta mümkün olduğunca ilerlemek istiyoruz. Ama recruit yaparken ne kadar uyumlu bir insan olduğunuz bizi oyunu ne kadar iyi oynadığınızdan daha çok ilgilendiriyor olacak."),
                      SizedBox(
                        height: 30,
                      ),
                      paragraphText(
                          "Aramıza katılmak ve bossları parçalamak için lütfen bize katıl butonundaki formu doldurun"),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
                FadeAnimation(
                  delay: 1000,
                  child: _buildButton(
                    "BİZE KATIL!",
                    Color(0xFF222835),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                FadeAnimation(
                  delay: 1200,
                  child: Image.asset(
                    "images/progress_pub.png",
                    width: 834,
                    height: 71,
                    scale: 1.4,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                FadeAnimation(
                  delay: 1400,
                  child: GestureDetector(
                    // onHorizontalDragStart: (a) {
                    //   isArselShow = true;
                    //   setState(() {});
                    // },
                    onHorizontalDragEnd: (a) {
                      if (a.velocity.pixelsPerSecond.dx > 500) {
                        isArselShow = true;

                        setState(() {});
                      }
                    },
                    child: Container(
                      color: Colors.yellowAccent.withOpacity(0.2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "YÖNETİM KADROMUZ",
                            style: style(20, letterSpacing: 5),
                          ),
                          Text(
                            "Bizlerle EU-Silvermoon realmi üzerinden iletişime geçebilirsiniz.",
                            style: style(12,
                                fontFamily: "", fontWeight: FontWeight.w200, letterSpacing: 0.4),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeAnimation(
                    delay: 1600,
                    child: Center(
                      child: Stack(
                        children: [
                          Image.asset("images/biz3.png", width: 878, height: 595),
                          if (isArselShow)
                            Positioned(
                              left: 400,
                              top: 80,
                              child: Image.asset(
                                "images/arsel.jpg",
                                scale: 3.0,
                              ),
                            ),
                        ],
                      ),
                    )),
                FadeAnimation(
                  delay: 1000,
                  child: _buildButton(
                    "Oyuncular",
                    Color(0xFF222835),
                    onPressed: () => pageChangePush(
                      context,
                      RosterPage(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 100,
                  color: Color(0xFF222835),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconButton(
                        "images/icons/wow.png",
                        () {
                          String link = "https://worldofwarcraft.com/en-gb/guild/eu/silvermoon/pub";
                          launchUrl(link);
                        },
                      ),
                      _buildIconButton(
                        "images/icons/progress.png",
                        () {
                          String link = "https://www.wowprogress.com/guild/eu/silvermoon/Pub";
                          launchUrl(link);
                        },
                      ),
                      _buildIconButton(
                        "images/icons/dc.png",
                        () {
                          String link = "https://discord.com/invite/NHckJgD";
                          launchUrl(link);
                        },
                      ),
                      _buildIconButton(
                        "images/icons/rio.png",
                        () {
                          String link = "https://raider.io/guilds/eu/silvermoon/Pub";
                          launchUrl(link);
                        },
                      ),
                      _buildIconButton(
                        "images/icons/logs.png",
                        () {
                          String link = "https://www.warcraftlogs.com/guild/eu/silvermoon/pub";
                          launchUrl(link);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget paragraphText(String text, {double width = 600}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: Container(
          width: width,
          alignment: Alignment.center,
          child: Text(
            text,
            style: style(14, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color color, {
    Function onPressed,
  }) {
    return Center(
      child: Container(
        width: 200,
        height: 50,
        child: InkWell(
          onTap: onPressed ??
              () {
                String link =
                    "https://docs.google.com/forms/d/e/1FAIpQLSfazCtybfdgjVRIBDYPpUr8nd1fI28KqETq0yhnImXgZp29ng/viewform?edit2=2_ABaOnudsQJz_a7Q7yrk9ZQMRXTC3eMmHNe82I090Uk_8UN211eHVztbIUulJegtCg27RY7o";
                launchUrl(link);
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) => FormPage()));
              },
          onHover: (val) {
            isHover = val;
            setState(() {});
          },
          child: Center(
            child: Container(
              width: 200,
              height: 50,
              decoration: isHover
                  ? BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF222835), Color(0xFF8a8a5b), Color(0xFF222835)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          // stops: [.25, .5, .75],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(30.0))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: color,
                    ),
              child: Center(
                child: Text(
                  text,
                  style: style(20, color: isHover ? Colors.white : Colors.lime[400]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(String iconLink, Function onPressed) {
    return GestureDetector(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Image.asset(
          iconLink,
          scale: 1.5,
        ),
      ),
      onTap: onPressed,
    );
  }

  void launchUrl(String url) {
    js.context.callMethod('open', [url]);
  }
}
