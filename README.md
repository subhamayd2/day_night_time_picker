# DayNightTimePicker

A day night time picker for Flutter.

<img src="https://raw.githubusercontent.com/subhamayd2/day_night_time_picker/master/example.gif" />

## Installation

Add to pubspec.yaml.

```yaml
dependencies:
  day_night_time_picker:
```

## Usage

To use plugin, just import package

```dart
import 'package:day_night_time_picker/day_night_time_picker.dart';
```

## Example

```dart
FlatButton(
    onPressed: () {
        Navigator.of(context).push(
            showPicker(
                context: context,
                value: _time,
                onChange: onTimeChanged,
            ),
        );
    },
    child: Text(
        "Open time picker",
        style: TextStyle(color: Colors.white),
    ),
),
```

## LICENCE

```
Copyright 2020 Subhamay Dutta

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
