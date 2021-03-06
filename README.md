# Bubble Loader
Show a beautiful & animated loading indicator.

<p align="center">
	<img src="https://github.com/taimoor522/bubble_loader/blob/master/example/demo/1.gif?raw=true" height="500" alt="Bubble Loader Demo" />
</p>

## Usage

```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: const BubbleLoader(
        color1: Colors.deepPurple,
        color2: Colors.deepOrange,
        bubbleGap: 10,
        bubbleScalingFactor: 1,
        duration: Duration(milliseconds: 1500),
      ),
    ),
  );
}
```

## Usage Scenarios

- Use as Splash Screen.
- Show until data loads from server.
