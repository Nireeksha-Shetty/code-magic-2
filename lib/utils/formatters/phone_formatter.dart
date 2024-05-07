
import 'package:flutter/services.dart';
import 'package:libphonenumber/libphonenumber.dart';

class PhoneFormatter extends TextInputFormatter {
  final void Function(TextEditingValue value) onPhoneFormatted;

  PhoneFormatter({required this.onPhoneFormatted});

  @override
  TextEditingValue formatEditUpdate(oldPhone, newPhone) {
    _formatPhone(newPhone.text.replaceAll(RegExp(r'[^\d\+]+'), ''))
        .then((String phone) {
      onPhoneFormatted(TextEditingValue(
          text: phone,
          selection: TextSelection.collapsed(offset: phone.length)));
    });
    return newPhone;
  }

  Future<String> _formatPhone(String phoneNumber) async {
    try {
      String? formattedPhoneNumber = await PhoneNumberUtil.formatAsYouType(
          phoneNumber: phoneNumber, isoCode: 'US');
      return formattedPhoneNumber ?? phoneNumber;
    } on Exception {
      return phoneNumber;
    }
  }
}
