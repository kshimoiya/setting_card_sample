import 'package:flutter/material.dart';
import 'package:setting_card_sample/model/filter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        backgroundColor: Colors.blue,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: 2,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return Container(
                      child: _Card(
                        child: _CheckBoxView(
                          title: 'CheckBox Filter',
                        ),
                      ),
                    );

                  return Container(
                    child: _Card(
                        child: _ChipView(
                      title: 'Chip Filter',
                    )),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ));
  }
}

const _kDefaultCardRadius = 40.0;

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_kDefaultCardRadius),
          bottomLeft: Radius.circular(_kDefaultCardRadius),
        ),
      ),
      elevation: 16.0,
      child: child,
    );
  }
}

class _CheckBoxView extends StatefulWidget {
  final List<int> currentValues;

  final String title;

  const _CheckBoxView({
    Key key,
    this.currentValues = const [],
    this.title,
  }) : super(key: key);

  @override
  __CheckBoxViewState createState() => __CheckBoxViewState();
}

class __CheckBoxViewState extends State<_CheckBoxView> {
  List<Filter> filters = [
    Filter(0, 'Filter 0'),
    Filter(1, 'Filter 1'),
    Filter(2, 'Filter 2'),
    Filter(3, 'Filter 3'),
    Filter(4, 'Filter 4'),
    Filter(5, 'Filter 5'),
  ];

  List<int> currentValues;

  @override
  void initState() {
    currentValues = widget.currentValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: _kDefaultCardRadius + 8.0, top: 16.0, bottom: 16.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.title),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[400],
          ),
          Column(
            children: List.generate(filters.length, (index) {
              return _CheckBox(
                value: filters[index].value,
                currentValues: currentValues,
                title: Text(filters[index].text),
                onChanged: (values) {
                  setState(() {
                    currentValues = values;
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  final int value;

  final List<int> currentValues;

  final Widget title;

  final Function(List<int> values) onChanged;

  const _CheckBox({
    Key key,
    @required this.value,
    @required this.currentValues,
    @required this.title,
    this.onChanged,
  })  : assert(value != null),
        assert(currentValues != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: currentValues.contains(value),
      onChanged: (bool value) {
        List<int> result = List.from(currentValues);
        if (currentValues.contains(this.value))
          result.remove(this.value);
        else
          result.add(this.value);

        onChanged(result);
      },
      title: title,
    );
  }
}

class _ChipView extends StatefulWidget {
  final List<int> currentValues;

  final String title;

  const _ChipView({
    Key key,
    this.currentValues = const [],
    this.title,
  }) : super(key: key);

  @override
  __ChipViewState createState() => __ChipViewState();
}

class __ChipViewState extends State<_ChipView> {
  List<Filter> filters = [
    Filter(0, 'Filter 0'),
    Filter(1, 'Filter 1'),
    Filter(2, 'Filter 2'),
    Filter(3, 'Filter 3'),
    Filter(4, 'Filter 4'),
    Filter(5, 'Filter 5'),
  ];

  List<int> currentValues;

  @override
  void initState() {
    currentValues = widget.currentValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: _kDefaultCardRadius + 8.0, top: 16.0, bottom: 16.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.title),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[400],
          ),
          Wrap(
            children: List.generate(filters.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _Chip(
                  value: filters[index].value,
                  currentValues: currentValues,
                  text: filters[index].text,
                  onChanged: (values) {
                    setState(() {
                      currentValues = values;
                    });
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final int value;

  final List<int> currentValues;

  final String text;

  final Function(List<int> values) onChanged;

  const _Chip({
    Key key,
    this.text,
    this.value,
    this.currentValues,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(text),
      selected: currentValues.contains(value),
      onSelected: (value) {
        List<int> result = List.from(currentValues);
        if (currentValues.contains(this.value))
          result.remove(this.value);
        else
          result.add(this.value);

        onChanged(result);
      },
    );
  }
}
