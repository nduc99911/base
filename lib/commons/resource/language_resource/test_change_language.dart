import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'localization_service.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String _selectedLang = LocalizationService.locale!.languageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
      ),
      body: Container(
        child: Center(
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            value: _selectedLang,
            items: _buildDropdownMenuItems(),
            onChanged: (String? value) {
              setState(() => _selectedLang = value!);
              LocalizationService.changeLocale(value!);
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    List<DropdownMenuItem<String>> list = [];
    LocalizationService.langs.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(key,style: TextStyle(color: Colors.black),),
      ));
    });
    return list;
  }
}
