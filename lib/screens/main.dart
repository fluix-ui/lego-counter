import 'package:flutter/material.dart';
import 'package:fluix/fluix.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FluidShell(
        appBar: FluidBar(
          color: Liquids.vibrantCyan.darker,
          title: Text("Test"),
          height: 70,
          // actions: <Widget>[
          //   SizedBox(
          //     width: MediaQuery.of(context).size.width / 2.5,
          //     child: FluidInput(
          //       hintText: "Suchen...",
          //       textInputAction: TextInputAction.search,
          //     ),
          //   ),
          //   FluidIconButton.ghost(
          //     icon: Icon(LiquidIcons.search),
          //   )
          // ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            FluidButton.highlight(
              child: Text("Open Sets"),
              onTap: () => Navigator.pushNamed(context, "/sets"),
            ),
            FluidButton.primary(
              child: Text("My Sets"),
              onTap: () => Navigator.pushNamed(context, "/mysets"),
            ),
          ],
        ),
      ),
    );
  }
}
