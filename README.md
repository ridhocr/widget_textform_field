# custom_text_form_field

[![pub package](https://img.shields.io/pub/v/widget_text_form_field.svg)](https://pub.dev/packages/widget_text_form_field)

A customizable `TextFormField` widget in Flutter with built-in support for validation, date/year pickers, and currency formatting.

## Features

- Custom border, icons, and label/hint support.
- Built-in support for:
  - Email validation
  - Date picker
  - Year picker
  - Currency formatting
- Support for readonly, multiline, max length, etc.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  custom_text_form_field: ^0.0.1+2
```

Then run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:custom_text_form_field/custom_text_form_field.dart';

CustomTextFormField(
  controller: TextEditingController(),
  labelText: "Enter amount",
  hintText: "0",
  type: "number",
  currency: true,
)
```

## Parameters

| Property       | Type                   | Description                                 |
|----------------|------------------------|---------------------------------------------|
| controller     | TextEditingController  | Required: Controls the input                |
| labelText      | String                 | Required: Label above input                 |
| hintText       | String                 | Required: Placeholder                       |
| type           | String?                | Optional: 'email', 'number', 'date', 'year' |
| readOnly       | bool?                  | Optional: Set read-only                     |
| currency       | bool?                  | Optional: Enable currency formatting        |
| prefixIcon     | Widget?                | Optional: Leading icon                      |
| suffixIcon     | Widget?                | Optional: Trailing icon                     |
| onChanged      | Function?              | Optional: Value change callback             |

## License

See [LICENSE](LICENSE) file.

## Example

See the [example](example/) directory for a complete sample app.
