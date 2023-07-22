import 'package:firebase_chat_app/modals/global/drawer_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class MenuItems {
  static const profile = MenuItem('My profile', Icons.person_pin);
  static const account = MenuItem('Account', Icons.key);
  static const privacy = MenuItem('Privacy', CupertinoIcons.lock_circle);
  static const chat = MenuItem('Chats', CupertinoIcons.chat_bubble_2_fill);
  static const setting = MenuItem('Setting', Icons.people_alt_outlined);
  static const support = MenuItem('Support', CupertinoIcons.phone);
  static const logout = MenuItem('Logout', Icons.logout);

  static const all = <MenuItem>[
    profile,
    account,
    privacy,
    chat,
    setting,
    support,
    logout,
  ];
}