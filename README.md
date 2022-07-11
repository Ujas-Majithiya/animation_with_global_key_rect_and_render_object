# Animation with GlobalKey, Rect and RenderObject demo

The first part demonstrates animations like IOS's app store scroll animation in any app details
page. And in second part, we can check if two widgets overlaps each other or not.

## Demo of what you can expect from this project
|Part-1| Part-2|
|-|-|
|<a href="https://raw.githubusercontent.com/Ujas-Majithiya/animation_with_global_key_rect_and_render_object/main/assets/part1.gif"><img src="https://raw.githubusercontent.com/Ujas-Majithiya/animation_with_global_key_rect_and_render_object/main/assets/part1.gif" width="390px;" height="700px;"/></a>|<a href="https://raw.githubusercontent.com/Ujas-Majithiya/animation_with_global_key_rect_and_render_object/main/assets/part1.gif"><img src="https://raw.githubusercontent.com/Ujas-Majithiya/animation_with_global_key_rect_and_render_object/main/assets/part2.gif" width="390px;" height="700px;"/></a>|

## Description

### Part-1

We will use global keys to track interactions between two widgets.

I have added this extension on global key which provides a `Rect` object. `Rect` provides us bunch
information about widget's position or size which we can use for animations.

```dart
extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
```

Now using this extension we will calculate both widget's position like this,
```dart
 _globalKey1.globalPaintBounds!.topCenter.dy;
```
Above code will give us the vertical position of widget's top center. Now, we can compare this with
other widget's position and check if the other widget passed through the first widget.

Also when get button touches the app bar in IOS's app store, it hides in the body and shows in the
app bar so we will calculate first widget's height using this
```dart
_globalKey1.globalPaintBounds!.height;
```
And add to first widget's position to get desired animation.

Now to calculate this continuously we will use a `ScrollController` and attach listener and inside
the listener we will calculate the position.

### Part-2

We will do minor changes in our code to check if two widgets overlap each other or not. So, `Rect`
object has one method called `overlaps` which returns `true` if two rectangle(means widgets)
overlaps otherwise it returns false.

There is also one another method which can be used for different scenarios. So, `Rect` has one
method called `intersect`. This method is called on a `Rect` object and also takes arguments as
`Rect` and also returns a `Rect` object. Now, This returned `Rect` object only has meaning if
two widgets are overlapping.

So, if two widgets doesn't overlap then returned `Rect` object's height or width will be negative.
So we can use it like below,
```dart
_globalKey2.globalPaintBounds!.intersect(_globalKey1.globalPaintBounds!).height > 0
      && _globalKey2.globalPaintBounds!.intersect(_globalKey1.globalPaintBounds!).width > 0
```

