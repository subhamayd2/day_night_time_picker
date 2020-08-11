# DayNightTimePicker

A day night time picker for Flutter with **Zero Dependencies**.

<img src="https://raw.githubusercontent.com/subhamayd2/day_night_time_picker/master/example.gif" />

## Installation

Add to pubspec.yaml.

```yaml
dependencies:
  day_night_time_picker:
```

---

## Usage

To use plugin, just import package

```dart
import 'package:day_night_time_picker/day_night_time_picker.dart';
```

---

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

---

## Props

| Name                   | Description                                                        |             Default             |
| :--------------------- | :----------------------------------------------------------------- | :-----------------------------: |
| **value**              | **`Required`** Display value. It takes in [TimeOfDay].             |
| **onChange**           | **`Required`** Return the new time the user picked as [TimeOfDay]. |
| **onChangeDateTime**   | _`Optional`_ Return the new time the user picked as [DateTime].    |
| **is24HrFormat**       | Show the time in TimePicker in 24 hour format.                     |             `false`             |
| **accentColor**        | Accent color of the TimePicker.                                    | `Theme.of(context).accentColor` |
| **unselectedColor**    | Color applied unselected options (am/pm, hour/minute).             |          `Colors.grey`          |
| **cancelText**         | Text displayed for the Cancel button.                              |            `cancel`             |
| **okText**             | Text displayed for the Ok button.                                  |              `ok`               |
| **sunAsset**           | Image asset used for the Sun.                                      |         Asset provided          |
| **moonAsset**          | Image asset used for the Moon.                                     |         Asset provided          |
| **blurredBackground**  | Whether to blur the background of the [Modal].                     |             `false`             |
| **barrierColor**       | Color of the background of the [Modal].                            |        `Colors.black45`         |
| **borderRadius**       | Border radius of the [Container] in [double].                      |             `10.0`              |
| **elevation**          | Elevation of the [Modal] in [double].                              |             `12.0`              |
| **barrierDismissible** | Whether clicking outside should dismiss the [Modal].               |             `true`              |

---

## Contributions

[![Nohli](https://avatars3.githubusercontent.com/u/43643339?s=64&u=b88f45bed5829b93b70f7980eee6d5748dc67d97&v=4)](https://github.com/nohli)

> ### **Thank you for your support**

---

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
