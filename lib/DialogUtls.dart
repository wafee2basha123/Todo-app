import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtls {

  static void showLoading({
    required BuildContext context,
    required String message,
    bool isDismissible = true,  String? title,  String? posActionName,Function()? posAction,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 12),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessage ({
    required BuildContext context,
    required String message,
    String? title,
    String? posAvtionName,
    Function? posAction,
    Function? negAction,
    String? negAvtionName,
    bool isDismissible = true
  }) {
    List<Widget> actions = [];
    if (posAvtionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (posAction != null) {
              posAction.call();
            }
          },
          child: Text(posAvtionName)
      ));
    }
    if (negAvtionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (negAction != null) {
              negAction.call();
            }
          },
          child: Text(negAvtionName)
      ));
    }
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            title: title != null ? Text(title, style: Theme.of(context).textTheme.titleMedium) : null,
            actions: actions,
          );
        }
    );
  }

}