import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog {
  final BuildContext context;
  final String message;

  ProgressDialog(this.context, {this.message = ""});

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white.withOpacity(0.7),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CupertinoActivityIndicator(
                  radius: 20,
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  child: Text(
                    this.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void dismiss() {
    Navigator.pop(this.context);
  }
}
