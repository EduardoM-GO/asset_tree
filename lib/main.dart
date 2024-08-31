import 'package:asset_tree/views/assets/view/assets_view.dart';
import 'package:asset_tree/views/companies/view/companies_view.dart';
import 'package:asset_tree/views/not_found/view/not_found_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    onGenerateRoute: _onGenerateRoute,
    theme: _themeData,
  ));
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  final Widget Function(BuildContext context) builder = switch (settings.name) {
    '/' => (BuildContext context) => const CompaniesView(),
    '/assets' => (BuildContext context) => AssetsView(
          companyId: settings.arguments as String,
        ),
    _ => (BuildContext context) => NotFoundView(settings: settings),
  };

  return MaterialPageRoute(builder: builder);
}

ThemeData get _themeData {
  return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF2188FF),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF17192D),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFF17192D),
        centerTitle: true,
      ),
      cardTheme: const CardTheme(color: Color(0xFF2188FF)),
      useMaterial3: false,
      dividerColor: Colors.transparent);
}
