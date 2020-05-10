import 'package:flutter/material.dart';

class CombinationsTypesRequired extends StatelessWidget {
  CombinationsTypesRequired({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Card(
        color: Colors.black38,
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            'OBRIGATÓRIO',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
