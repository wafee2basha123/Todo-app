import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/Listprovider.dart';

// ThemeBottomSheet widget
// ThemeBottomSheet widget
class ThemeBottomSheet extends StatefulWidget {
  final ThemeMode currentThemeMode;

  const ThemeBottomSheet({Key? key, required this.currentThemeMode}) : super(key: key);

  @override
  _ThemeBottomSheetState createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  String _selectedTheme = ''; // Default no theme selected

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Dark'), // Static text
            onTap: () {
              Provider.of<ListProvider>(context, listen: false).changeTheme(ThemeMode.dark); // Change theme to dark
              setState(() {
                _selectedTheme = 'dark';
              });
              Navigator.pop(context);
            },
            leading: _selectedTheme == 'dark'
                ? Icon(Icons.check, color: _getCheckColor())
                : null,
          ),
          Divider(),
          ListTile(
            title: Text('Light'), // Static text
            onTap: () {
              Provider.of<ListProvider>(context, listen: false).changeTheme(ThemeMode.light); // Change theme to light
              setState(() {
                _selectedTheme = 'light';
              });
              Navigator.pop(context);
            },
            leading: _selectedTheme == 'light'
                ? Icon(Icons.check, color: _getCheckColor())
                : null,
          ),
        ],
      ),
    );
  }

  Color _getCheckColor() {
    if (widget.currentThemeMode == ThemeMode.light) {
      return Colors.black; // Set text color to black for light theme
    } else {
      return Colors.white; // Set text color to white for dark theme
    }
  }
}
