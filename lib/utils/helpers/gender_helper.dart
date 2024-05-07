enum Gender {
  Male,
  Female,
  NA,
}

extension GenderExtension on Gender {
  String get name {
    switch (this) {
      case Gender.Male:
        return "Male";
      case Gender.Female:
        return "Female";
      default:
        return "N/A";
    }
  }
}

extension GenderExtensionAbrrevation on Gender {
  String get value {
    switch (this) {
      case Gender.Male:
        return "M";
      case Gender.Female:
        return "F";
      default:
        return "N/A";
    }
  }
}

Gender stringAbrToGender(String? gender) {
  switch (gender) {
    case 'M':
      return Gender.Male;
    case 'F':
      return Gender.Female;
    default:
      return Gender.NA;
  }
}