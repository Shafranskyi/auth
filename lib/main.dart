import 'package:flutter/material.dart';

////  Imports for platform info ////
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/foundation.dart' show TargetPlatform;

////  Imports for App Center ////
import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World\'s Best Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'World\'s Best Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _appCenterIdentifier = "db7adcb0-7872-46d2-8ace-3798d6fce2fd";

  final TextEditingController eCtrl = new TextEditingController();
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    initAppCenter();
  }

////  Initialise AppCenter ////
  void initAppCenter() async {
// Initialise AppCenter to allow for event tracking and crash reporting
    await AppCenter.start(
        _appCenterIdentifier, [AppCenterAnalytics.id, AppCenterCrashes.id]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      ////  Body of the app is made up of a single column ////
      body: new Column(
        children: <Widget>[
          ////  TextField to capture input ////
          new TextField(
            controller: eCtrl,
            onSubmitted: (text) {
              AppCenterAnalytics.trackEvent("Adding item", {"List Item": text});
              tasks.add(text);
              eCtrl.clear();
              setState(() {});
            },
          ),

          ////  Expand ListView to remaining space ////
          new Expanded(
            child: new ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                  child: Text(tasks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}