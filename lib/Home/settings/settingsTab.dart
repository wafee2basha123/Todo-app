import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Home/settings/themeSheet.dart';

import '../../mytheme.dart';
import '../../provider/Listprovider.dart';
import 'languagebottom.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);
  static const String routeName = 'settingscreen';
  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Language', // Static text
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                fontWeight: FontWeight.bold,
                color: MyTheme.primaryColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appLanguage == 'en' ? 'English' : 'Arabic',
                    // Changed to static text
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Modes', // Static text
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                fontWeight: FontWeight.bold,
                color: MyTheme.primaryColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showThemeButtonSheet(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appTheme == ThemeMode.light ? 'Light' : 'Dark',
                    // Changed to static text
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeButtonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ThemeBottomSheet(currentThemeMode: Provider
              .of<ListProvider>(context)
              .appTheme),
    );
  }
}
