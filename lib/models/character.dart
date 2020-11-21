import 'dart:convert';

class Character {
  String name;
  num equippedItemLevel;
  num averageItemLevel;
  num level;
  num achievementPoint;
  String gender;
  String race;
  String characterClass;
  String activeSpec;
  String cardImage;
  String mainImage;
  String rank;

  Character({
    this.name,
    this.equippedItemLevel,
    this.averageItemLevel,
    this.level,
    this.achievementPoint,
    this.gender,
    this.race,
    this.characterClass,
    this.activeSpec,
    this.cardImage,
    this.mainImage,
    this.rank,
  });

  Character copyWith({
    String name,
    num equippedItemLevel,
    num averageItemLevel,
    num level,
    num achievementPoint,
    String gender,
    String race,
    String characterClass,
    String activeSpec,
    String cardImage,
    String mainImage,
    String rank,
  }) {
    return Character(
      name: name ?? this.name,
      equippedItemLevel: equippedItemLevel ?? this.equippedItemLevel,
      averageItemLevel: averageItemLevel ?? this.averageItemLevel,
      level: level ?? this.level,
      achievementPoint: achievementPoint ?? this.achievementPoint,
      gender: gender ?? this.gender,
      race: race ?? this.race,
      characterClass: characterClass ?? this.characterClass,
      activeSpec: activeSpec ?? this.activeSpec,
      cardImage: cardImage ?? this.cardImage,
      mainImage: mainImage ?? this.mainImage,
      rank: rank ?? this.rank,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'equippedItemLevel': equippedItemLevel,
      'averageItemLevel': averageItemLevel,
      'level': level,
      'achievementPoint': achievementPoint,
      'gender': gender,
      'race': race,
      'characterClass': characterClass,
      'activeSpec': activeSpec,
      'cardImage': cardImage,
      'mainImage': mainImage,
      'rank': rank,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Character(
      name: map['name'],
      equippedItemLevel: map['equippedItemLevel'],
      averageItemLevel: map['averageItemLevel'],
      level: map['level'],
      achievementPoint: map['achievementPoint'],
      gender: map['gender'],
      race: map['race'],
      characterClass: map['characterClass'],
      activeSpec: map['activeSpec'],
      cardImage: map['cardImage'],
      mainImage: map['mainImage'],
      rank: map['rank'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) => Character.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Character(name: $name, equippedItemLevel: $equippedItemLevel, averageItemLevel: $averageItemLevel, level: $level, achievementPoint: $achievementPoint, gender: $gender, race: $race, characterClass: $characterClass, activeSpec: $activeSpec, cardImage: $cardImage, mainImage: $mainImage, rank: $rank)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Character &&
        o.name == name &&
        o.equippedItemLevel == equippedItemLevel &&
        o.averageItemLevel == averageItemLevel &&
        o.level == level &&
        o.achievementPoint == achievementPoint &&
        o.gender == gender &&
        o.race == race &&
        o.characterClass == characterClass &&
        o.activeSpec == activeSpec &&
        o.cardImage == cardImage &&
        o.mainImage == mainImage &&
        o.rank == rank;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        equippedItemLevel.hashCode ^
        averageItemLevel.hashCode ^
        level.hashCode ^
        achievementPoint.hashCode ^
        gender.hashCode ^
        race.hashCode ^
        characterClass.hashCode ^
        activeSpec.hashCode ^
        cardImage.hashCode ^
        mainImage.hashCode ^
        rank.hashCode;
  }
}

class RankTypes {
  static const String GUILDMASTER = "GUILDMASTER";
  static const String OFFICER = "OFFICER";
  static const String BANKER = "BANKER";
  static const String RAIDER = "RAIDER";

  static String getRankFromNumber(int rank) {
    switch (rank) {
      case 0:
        return GUILDMASTER;
        break;
      case 1:
        return OFFICER;
        break;
      case 2:
        return BANKER;
        break;
      case 4:
        return RAIDER;
        break;
      default:
        return "";
    }
  }
}
