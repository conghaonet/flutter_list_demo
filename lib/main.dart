import 'package:flutter/material.dart';
import 'package:flutterlistdemo/list_page.dart';
import 'package:flutterlistdemo/province_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProvinceNotifier>(create: (_) => ProvinceNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    await DefaultAssetBundle.of(context).loadString('assets/city_code.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('list_page'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
