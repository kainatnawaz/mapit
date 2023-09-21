
# MapIt

MapIt package lets you add map in your app,search and place markers.

## Installation

1. Add the latest version of package to your pubspec.yaml (and run`dart pub get`):
```yaml
dependencies:
  mapit: ^0.0.4
```
2. Import the package and use it in your Flutter App.
```dart
import 'package:mapit/mapit.dart';
```

## Example
There are a number of properties that you can modify:

- selectedLocation
- address CallBack

<hr>

<table>
<tr>
<td>

```dart
class ShowMapScreen extends StatelessWidget {  
  const ShowMapScreen({Key? key}) : super(key: key);  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: Center(  
        child: const GoogleMapScreen(address: (val){
          var location=val;
        },),  
      ),  
    );  
  }  
}
```

</td>
<td>
<img  src="https://github.com/kainatnawaz/mapit/blob/main/WhatsApp%20Image%202023-09-20%20at%2011.02.56%20AM.jpeg"  alt="">
</td>
</tr>
</table>

## Next Goals

- [x] Use address Callback functions.
  Now, you can specify the save address from GoogleMapScreen.
