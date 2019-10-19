import 'package:fluix/fluix.dart';
import 'package:flutter/material.dart';
import 'package:lego_count/models/set.dart';
import 'dart:convert';
import 'dart:html' as html;

class ExportScreen extends StatelessWidget {
  final LegoSet sett;
  final int mode;

  ExportScreen(this.sett, this.mode);

  String _toSet() {
    return json.encode(sett.toJson());
  }
  String _toJson() {
    return json.encode(_getParts().map((part) => part.toJson()).toList());
  }

  String _toCsv() {
    return "id, Name, Quantity, Owned Quantity, is spare\n" +
        _getParts().map((part) => part.toCsv()).join("\n");
  }

  String _toText() {
    return _getParts().map((part) => part.toText(mode: mode)).join("\n");
  }

  List<Part> _getParts() {
    switch (mode) {
      case 1:
        return sett.showExisting;
      case 2:
        return sett.showMissing;
    }
    return sett.parts;
  }

  @override
  Widget build(BuildContext context) {
    return FluidShell(
      appBar: FluidBar(
        height: 80,
        color: Liquids.vibrantYellow,
        automaticallyImplyLeading: false,
        title: Text("Exportieren als"),
        actions: <Widget>[
          FluidIconButton.highlight(
            icon: Icon(LiquidIcons.close),
            onTap: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          FluidTabs(
            [
              FluidTab(
                "Text",
                child: SelectableTextCard(_toText()),
              ),
              FluidTab(
                "JSON",
                child: SelectableTextCard(_toJson()),
              ),
              FluidTab(
                "CSV",
                child: SelectableTextCard(_toCsv()),
              ),
              FluidTab(
                "Set",
                child: SelectableTextCard(_toSet()),
              ),
            ],
            scrollable: true,
          ),
        ],
      ),
    );
  }
}

class SelectableTextCard extends StatelessWidget {
  final String text;

  SelectableTextCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FluidIconButton(
            icon: Icon(LiquidIcons.clip),
            child: Text("Kopieren"),
            onTap: () => html.window.navigator.clipboard.writeText(text),
          ),
          SizedBox(
            height: 8,
          ),
          FluidCard(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
