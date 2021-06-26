import 'package:flutter/material.dart';
import 'package:mineapp/screens/AltProfile/altProfileHelper.dart';
import 'package:provider/provider.dart';

class AltProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          Provider.of<AltProfileHelper>(context, listen: false).appBar(context),
    );
  }
}
