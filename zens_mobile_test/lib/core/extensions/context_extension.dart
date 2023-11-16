import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextEx on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primary => colorScheme.primary;

  Color get primaryContainer => colorScheme.primaryContainer;

  Color get secondary => colorScheme.secondary;

  Color get tertiary => colorScheme.tertiary;

  Color get secondaryContainer => colorScheme.secondaryContainer;

  Color get surface => colorScheme.surface;

  Color get background => colorScheme.background;

  Color get error => colorScheme.error;

  Color get onPrimary => colorScheme.onPrimary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get onSurface => colorScheme.onSurface;

  Color get onBackground => colorScheme.onBackground;

  Color get onError => colorScheme.onError;

  TextTheme get textTheme => Theme.of(this).textTheme;

  // TextStyle get overline => Theme.of(this).textTheme.labelSmall!;

  // TextStyle get caption => Theme.of(this).textTheme.bodySmall!;

  // TextStyle get button => Theme.of(this).textTheme.labelLarge!;

  // TextStyle get bodyText2 => Theme.of(this).textTheme.bodyMedium!;

  // TextStyle get bodyText1 => Theme.of(this).textTheme.bodyLarge!;

  // TextStyle get subtitle2 => Theme.of(this).textTheme.titleSmall!;

  // TextStyle get subtitle1 => Theme.of(this).textTheme.titleMedium!;

  // TextStyle get headline1 => Theme.of(this).textTheme.displayLarge!;

  // TextStyle get headline2 => Theme.of(this).textTheme.displayMedium!;

  // TextStyle get headline3 => Theme.of(this).textTheme.displaySmall!;

  // TextStyle get headline4 => Theme.of(this).textTheme.headlineMedium!;

  // TextStyle get headline5 => Theme.of(this).textTheme.headlineSmall!;

  // TextStyle get headline6 => Theme.of(this).textTheme.titleLarge!;

  TextStyle get displayLarge => textTheme.displayLarge!;
  TextStyle get displayMedium => textTheme.displayMedium!;
  TextStyle get displaySmall => textTheme.displaySmall!;
  TextStyle get headlineLarge => textTheme.headlineLarge!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;

  Size get mediaSize => MediaQuery.sizeOf(this);

  double get width => mediaSize.width;

  double get height => mediaSize.height;

  double get scale => MediaQuery.devicePixelRatioOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  Color get dividerColor => Theme.of(this).dividerColor;

  Color get canvasColor => Theme.of(this).canvasColor;

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  double get widthScale => width > height ? height : width;

  double get heightScale => width < height ? height : width;

  int get widthPixels => (width * height).toInt();

  int get heightPixels => (height * scale).toInt();

  NavigatorState? get navigator => Navigator.of(this);

  double get widthDefault => 375.0;

  double get heightDefault => 812.0;

  double dynamicSize(
    double size, {
    bool dynamicWidth = false,
    Orientation orientation = Orientation.portrait,
  }) {
    if (dynamicWidth || orientation == Orientation.landscape) {
      if (width >= widthDefault) return size;
      return size * width / widthDefault;
    } else {
      if (height >= heightDefault) return size;
      return size * height / heightDefault;
    }
  }

  Future<T?> pushPage<T>(Widget child, {String? name}) async {
    return await navigator!.push<T>(
      MaterialPageRoute(
        builder: (context) => child,
        settings: RouteSettings(name: name),
      ),
    );
  }

  Future<T?> dialog<T>(
    Widget child, {
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) =>
      showDialog(
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        context: this,
        routeSettings: RouteSettings(
          name: child.toString(),
        ),
        builder: (context) => child,
      );
}

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

  Future<T?> showDropDown<T>(
    BuildContext context, {
    required List<T> option,
    ValueChanged<T?>? onTap,
    Widget Function(BuildContext context, T item)? builder,
    Alignment alignment = Alignment.centerLeft,
    EdgeInsets? padding,
  }) async {
    final button = currentContext?.findRenderObject()! as RenderBox;
    final overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          Offset(0, button.size.height),
          ancestor: overlay,
        ),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero) + Offset.zero,
          ancestor: overlay,
        ),
      ),
      Offset(0, -4.h) & overlay.size,
    );
    return showMenu<T?>(
      context: context,
      elevation: 2,
      color: context.surface,
      surfaceTintColor: context.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 3,
        minWidth: button.size.width,
      ),
      position: position,
      items: option.map((e) {
        return PopupMenuItem<T>(
          onTap: () {
            onTap?.call(e);
          },
          padding: padding,
          child: builder?.call(context, e) ??
              Align(
                alignment: alignment,
                child: Text(
                  e.toString(),
                  style: context.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        );
      }).toList(),
    );
  }
}
