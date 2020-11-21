import 'dart:convert';

import 'package:pub_site/config/response_types.dart';
import 'package:http/http.dart' as http;
import 'package:pub_site/models/character.dart';

class ServiceConfig {
  static const String namespace = "profile-eu";
  static const String locale = "en_GB";

  static String guildRosterEndpoint(String guildName, String _token) {
    return "https://eu.api.blizzard.com/data/wow/guild/silvermoon/$guildName/roster?namespace=$namespace&locale=$locale&access_token=$_token";
  }

  static String getCharacterInfoEndpoint(String characterName, String _token) {
    return "https://eu.api.blizzard.com/profile/wow/character/silvermoon/${characterName.toLowerCase()}?namespace=$namespace&locale=$locale&access_token=$_token";
  }

  static String getCharacterImageEndpoint(String characterName, String _token) {
    return "https://eu.api.blizzard.com/profile/wow/character/silvermoon/${characterName.toLowerCase()}/character-media?namespace=$namespace&locale=$locale&access_token=$_token";
  }

  static Future<String> getTokenResponse(String token) async {
    Map<String, dynamic> body = {"grant_type": "client_credentials"};
    var tokenResponse = await http.post("https://us.battle.net/oauth/token",
        headers: {"Authorization": "Basic $token"}, body: body);
    return json.decode(tokenResponse.body)["access_token"];
  }
}

Future<ListApiResponse<Character>> getRosterFromGuild(String guildName, String _token) async {
  String endpoint = ServiceConfig.guildRosterEndpoint(guildName, _token);
  var response = await http.get(endpoint);
  List<Character> characterList = List();
  if (response == null) {
    return ListApiResponse(404, "Karakterler çekilirken hata oluştu!", []);
  } else {
    var decodedResponse = json.decode(response.body);
    for (var memberJson in decodedResponse["members"]) {
      if (memberJson["character"]["level"] == 50 && memberJson["rank"] <= 4) {
        var name = memberJson["character"]["name"];
        var characterInfoResponse =
            await http.get(ServiceConfig.getCharacterInfoEndpoint(name, _token));
        var characterImageResponse =
            await http.get(ServiceConfig.getCharacterImageEndpoint(name, _token));
        var decodedInfoResponse = json.decode(characterInfoResponse.body);
        var decodedImageResponse = json.decode(characterImageResponse.body);
        String cardImage = "";
        String mainImage = "";
        if (decodedImageResponse["assets"] == null) {
          cardImage = decodedImageResponse["bust_url"];
          mainImage = decodedImageResponse["render_url"];
        } else {
          cardImage = decodedImageResponse["assets"][1]["value"];
          mainImage = decodedImageResponse["assets"][3]["value"];
        }
        Character character = Character(
          name: name,
          level: memberJson["character"]["level"],
          rank: RankTypes.getRankFromNumber(memberJson["rank"]),
          cardImage: cardImage,
          mainImage: mainImage,
          achievementPoint: decodedInfoResponse["achievement_points"],
          race: decodedInfoResponse["race"]["name"],
          activeSpec: decodedInfoResponse["active_spec"]["name"],
          averageItemLevel: decodedInfoResponse["average_item_level"],
          equippedItemLevel: decodedInfoResponse["equipped_item_level"],
          characterClass: decodedInfoResponse["character_class"]["name"],
          gender: decodedInfoResponse["gender"]["name"],
        );
        characterList.add(character);
      }
    }
    characterList.forEach((element) {
      print(element.toString());
    });
    return ListApiResponse(200, "", characterList);
  }
}
