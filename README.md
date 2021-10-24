# Weather App

My first mobile app.

## App Properties

This app is a weather app.

I use in app [Open Weather Api](https://openweathermap.org/).

When you want to change city, you have to change:

Path: "/lib/main.dart#L23"

```dart

  var url = "https://api.openweathermap.org/data/2.5/weather?q={The City You Want}&units=metric&appid=351f6f012c85e4d8fbd878e3fcc6304a";
                                                             //^^^^^^^^^^^^^^^^^^\\
```
