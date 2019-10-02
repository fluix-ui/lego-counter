import 'dart:convert';

import 'package:fluix/fluix.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lego_count/models/my_sets.dart';
import 'package:lego_count/models/sets.dart';
import 'package:provider/provider.dart';

class ImportScreen extends StatefulWidget {
  ImportScreen();

  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  final _controller = TextEditingController();
  String error;

  String validateInput(){
    var t = _controller.text;
    if(t.trim().isEmpty) return "Bitte etwas eingeben.";
    Map<String,dynamic> inp;
    try {
      inp = json.decode(t);
      if(inp["set_num"] == null) return "Die Set Nummer fehlt!";
      if(inp["name"] == null) return "Der Set Name fehlt!";
      if(inp["parts"] == null) return "Die Teile des Sets fehlen";
      
    } catch (e) {
      return "Ein Fehler bei der Konvertierung ist aufgetreten, bitte Eingabe überprüfen!";
    }
    MySets mySets = Provider.of<MySets>(context);
    LegoSet myset = LegoSet.fromJson(inp);
    if(mySets.add(myset)) return "";
    return "Dieses Set existiert bereits, lösche es bitte vorher!";
  }

  import(){
    String res = validateInput();
    if(res.isEmpty) Navigator.of(context).pop();
    else setState(() {
      error = res;
    });
  }

  @override
  Widget build(BuildContext context) {

    

    return FluidShell(
      appBar: FluidBar(
        height: 80,
        color: Liquids.vibrantYellow,
        title: Text("Importieren"),
        actions: <Widget>[
          FluidIconButton.highlight(
            icon: Icon(LiquidIcons.arrowcheck),
            onTap: () => import(),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FluidIconButton.primary(
                icon: Icon(LiquidIcons.clip),
                child: Text("Einfügen"),
                onTap: () => Clipboard.getData("text/plain").then(
                  (val) => setState(
                    () {
                      _controller.text = val.text;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height / 2,
                child: FluidMultiInput(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  hintText: "Eingabe",
                  maxLines: 99,
                  expands: true,
                ),
              ),
              if(error != null) Text(error,style: TextStyle(color:Liquids.richRed),)
            ],
          ),
        ],
      ),
    );
  }
}
