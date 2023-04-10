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

  Person(
      int orderNo,
      String name,
      String gender,
      String politicalStatus,
      String dateOfBirth,
      String workPosition,
      String city,
      String telephone,
      String groupType) {
    this.orderNo = orderNo;
    this.name = name;
    this.gender = gender;
    this.politicalStatus = politicalStatus;
    this.dateOfBirth = dateOfBirth;
    this.workPosition = workPosition;
    this.city = city;
    this.telephone = telephone;
    this.groupType = groupType;
  }

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
      'groupType': groupType
    };
  }
}
