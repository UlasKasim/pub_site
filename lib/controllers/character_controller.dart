import 'package:get/get.dart';
import 'package:pub_site/config/secret_config.dart';
import 'package:pub_site/config/service_config.dart';
import 'package:pub_site/models/character.dart';

class CharacterController extends GetxController {
  String token;
  List<Character> characterList = List();

  @override
  void onInit() async {
    super.onInit();
    token = await ServiceConfig.getTokenResponse(Secret.token);
    var guildResponse = await getRosterFromGuild("pub", token);
    if (guildResponse.statusCode.toString().startsWith('20')) {
      characterList = guildResponse.data;
    }
    print("test");
  }

  List<Character> getCharacterListByRank(String rankType) {
    return characterList.where((element) => element.rank == rankType).toList();
  }
}
