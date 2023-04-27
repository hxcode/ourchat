class Person {
  late int orderNo;
  late String name;
  late String gender;
  late String politicalStatus;
  late String dateOfBirth;
  late String workPosition;
  late String city;
  late String telephone;
  late String groupType;
  late String industry;
  late String techLevel;
  late String topSchool;
  late String birthWhere;
  late String birthWhereContact;
  late String birthWhereContactPhone;
  late String family;

  Person(
      {required this.orderNo,
      required this.name,
      required this.gender,
      required this.politicalStatus,
      required this.dateOfBirth,
      required this.workPosition,
      required this.city,
      required this.telephone,
      required this.groupType,
      required this.industry,
      required this.techLevel,
      required this.topSchool,
      required this.birthWhere,
      required this.birthWhereContact,
      required this.birthWhereContactPhone,
      required this.family});

  int get getOrderNo {
    return orderNo;
  }

  String get getName {
    return name;
  }

  String get getGender {
    return gender;
  }

  String get getPoliticalStatus {
    return politicalStatus;
  }

  String get getDateOfBirth {
    return dateOfBirth;
  }

  String get getWorkPosition {
    return workPosition;
  }

  String get getCity {
    return city;
  }

  String get getTelephone {
    return telephone;
  }

  String get getGroupType {
    return groupType;
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'name': name,
      'gender': gender,
      'politicalStatus': politicalStatus,
      'dateOfBirth': dateOfBirth,
      'workPosition': workPosition,
      'telephone': telephone,
      'city': city,
      'groupType': groupType,
      'industry': industry,
      'techLevel': techLevel,
      'topSchool': topSchool,
      'birthWhere': birthWhere,
      'birthWhereContact': birthWhereContact,
      'birthWhereContactPhone': birthWhereContactPhone,
      'family': family
    };
  }
}
