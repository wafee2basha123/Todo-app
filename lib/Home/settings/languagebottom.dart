import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/Listprovider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  _LanguageBottomSheetState createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String _selectedLanguage = ''; // Default no language selected

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English'), // Static text
            onTap: () {
              provider.changeLanguage('en');
              setState(() {
                _selectedLanguage = 'English';
              });
            },
            leading: _selectedLanguage == 'English'
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : null,
          ),
          Divider(),
          ListTile(
            title: Text('Arabic'), // Static text
            onTap: () {
              provider.changeLanguage('ar');
              setState(() {
                _selectedLanguage = 'Arabic';
              });
            },
            leading: _selectedLanguage == 'Arabic'
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : null,
          ),
        ],
      ),
    );
  }
}
