// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:firebase_chat_app/modals/global/log_in_out.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';

class Google_login_out_GetController {
  Google_login_out_Modal google_login_out_modal =
      Google_login_out_Modal(isLogin: box.read('isLogin') ?? false);

  trueValue() {
    google_login_out_modal.isLogin = true;

    box.write('isLogin', google_login_out_modal.isLogin);
  }
  falseValue() {
    google_login_out_modal.isLogin = false;

    box.write('isLogin', google_login_out_modal.isLogin);
  }
}
