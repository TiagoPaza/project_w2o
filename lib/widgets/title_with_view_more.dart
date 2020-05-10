import 'package:flutter/material.dart';

class TitleWithViewMore extends StatelessWidget {
  final String title;
  final String linkName;
  final String screen;

  TitleWithViewMore(this.title, this.screen, {this.linkName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          this.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        FlatButton(
          child: Text(
            this.linkName ?? 'Ver mais',
            style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(this.screen);
          },
        ),
      ],
    );
  }
}
