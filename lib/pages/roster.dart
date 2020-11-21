import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pub_site/animations/fade_animation.dart';
import 'package:pub_site/controllers/character_controller.dart';
import 'package:pub_site/helper/page_change_helper.dart';
import 'package:pub_site/models/character.dart';

class RosterPage extends StatefulWidget {
  @override
  _RosterPageState createState() => _RosterPageState();
}

class _RosterPageState extends State<RosterPage> {
  CharacterController characterController = Get.find();
  @override
  Widget build(BuildContext context) {
    List<Character> guildMasterList =
        characterController.getCharacterListByRank(RankTypes.GUILDMASTER);
    List<Character> officerList = characterController.getCharacterListByRank(RankTypes.OFFICER);
    List<Character> bankerList = characterController.getCharacterListByRank(RankTypes.BANKER);
    List<Character> raiderList = characterController.getCharacterListByRank(RankTypes.RAIDER);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FadeAnimation(
                    delay: 400,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green.withOpacity(0.2),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.chevron_left_sharp),
                            onPressed: () {
                              goBack(context);
                            },
                          ),
                          Expanded(
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
                          SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "GUILD MASTER",
                    style: style(25),
                  ),
                  buildGridView(guildMasterList),
                  Text(
                    "OFFICER",
                    style: style(25),
                  ),
                  buildGridView(officerList),
                  Text(
                    "YANCI",
                    style: style(25),
                  ),
                  buildGridView(bankerList),
                  Text(
                    "RAIDER",
                    style: style(25),
                  ),
                  buildGridView(raiderList),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GridView buildGridView(List<Character> cList) {
    print(MediaQuery.of(context).size.width);
    int count = 4;
    if (MediaQuery.of(context).size.width < 1500) count = 3;
    if (MediaQuery.of(context).size.width < 1200) count = 2;
    if (MediaQuery.of(context).size.width < 800) count = 1;
    // else if()
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        childAspectRatio: count == 1 ? 2.5 : 2,
      ),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: cList.length,
      itemBuilder: (_, i) {
        return cardWidget(cList[i]);
      },
    );
  }

  Widget cardWidget(Character character) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(
        children: [
          Image.network(
            character.mainImage,
            fit: BoxFit.cover,
            height: 300,
            width: 150,
          ),
          Expanded(
              child:
                  Card(color: Colors.green.withOpacity(0.2), child: _buildInfoColumn(character))),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(Character character) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCharacterInfo("İsim:", character.name),
          _buildCharacterInfo("Irk:", character.race),
          _buildCharacterInfo("Cinsiyet:", character.gender),
          _buildCharacterInfo("Level:", character.level.toString()),
          _buildCharacterInfo("Class:", character.characterClass),
          _buildCharacterInfo("Spec:", character.activeSpec),
          _buildCharacterInfo("Achievements:", character.achievementPoint.toString()),
          _buildCharacterInfo("E. iLvl:", character.equippedItemLevel.toString()),
          _buildCharacterInfo("A. iLvl:", character.averageItemLevel.toString()),
        ],
      ),
    );
  }

  Widget _buildCharacterInfo(String key, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: style(10),
          ),
          Text(
            value,
            style: style(10),
          ),
        ],
      ),
    );
  }

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
}
