import 'package:easy_localization/easy_localization.dart';

String validatePhoneNumber(String value) {
  final String pattern =
      r'^[+]{0,1}[\s]{0,1}[\d]{0,3}[\s]{0,1}[-(]{0,1}[\d]{1,4}[-)]{0,1}[\s]{0,1}[-\s\.\d]{3,10}$';
  RegExp regExp = RegExp(pattern);

  if (!regExp.hasMatch(value) || value.length < 10) {
    return 'INVALID_PHONE_REGEX'.tr();
  } else {
    return null;
  }
}
