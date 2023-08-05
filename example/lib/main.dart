import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Popup Picker Style",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "${_time.hour}:${_time.minute}:${_time.second} ${_time.period.name}"
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        showSecondSelector: true,
                        context: context,
                        value: _time,
                        onChange: onTimeChanged,
                        minuteInterval: TimePickerInterval.FIVE,
                        // Optional onChange to receive value as DateTime
                        onChangeDateTime: (DateTime dateTime) {
                          // print(dateTime);
                          debugPrint("[debug datetime]:  $dateTime");
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Open time picker",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  "Inline Picker Style",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Render inline widget
                showPicker(
                  isInlinePicker: true,
                  elevation: 1,
                  value: _time,
                  onChange: onTimeChanged,
                  minuteInterval: TimePickerInterval.FIVE,
                  iosStylePicker: iosStyle,
                  minHour: 9,
                  maxHour: 21,
                  is24HrFormat: false,
                  displayBanner: false
                ),
                Text(
                  "IOS Style",
                  style: Theme.of(context).textTheme.bodyLarge,
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
        ),
      ),
    );
  }
}
