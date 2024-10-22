import 'package:flutter/material.dart';

class AppTheme {
  static CardTheme cardTheme = CardTheme(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        elevation: 8,
        color: colorScheme.primaryContainer,
      );

  static ThemeData theme({
    required ColorScheme colorScheme,
    TextTheme textTheme = const TextTheme(),
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      cardTheme: cardTheme,
      listTileTheme: listTileTheme,
      appBarTheme: appBarTheme(colorScheme),
    );
  }
}
