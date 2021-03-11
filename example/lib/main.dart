import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Popup Picker Style",
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              _time.format(context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: _time,
                    onChange: onTimeChanged,
                    minuteInterval: MinuteInterval.FIVE,
                    disableHour: false,
                    disableMinute: false,
                    minMinute: 7,
                    maxMinute: 56,
                    // Optional onChange to receive value as DateTime
                    onChangeDateTime: (DateTime dateTime) {
                      print(dateTime);
                    },
                  ),
                );
              },
              child: Text(
                "Open time picker",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              "Inline Picker Style",
              style: Theme.of(context).textTheme.headline6,
            ),
            // Render inline widget
            createInlinePicker(
              elevation: 1,
              value: _time,
              onChange: onTimeChanged,
              minuteInterval: MinuteInterval.FIVE,
              iosStylePicker: iosStyle,
              minMinute: 7,
              maxMinute: 56,
            ),
            Text(
              "IOS Style",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Switch(
              value: iosStyle,
              onChanged: (newVal) {
                setState(() {
                  iosStyle = newVal;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
