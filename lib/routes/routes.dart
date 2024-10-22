// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_staff_portal/pages/app_page/app_page.dart';
import 'package:proklinik_staff_portal/pages/loading_page/loading_page.dart';
import 'package:proklinik_staff_portal/pages/login_page/login_page.dart';
import 'package:proklinik_staff_portal/utils/navigator_key.dart';

class AppRouter {
  static const String loadingscreen = '/';
  static const String login = 'login';
  static const String app = 'app/:id';

  static final GoRouter router = GoRouter(
    initialLocation: loadingscreen,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: loadingscreen,
        path: loadingscreen,
        builder: (context, state) {
          return LoadingPage(
            key: state.pageKey,
          );
        },
        redirect: (context, state) async {
          if (state.fullPath == loadingscreen) {
            await Future.delayed(
              const Duration(seconds: 2),
            );
            return '/$login';
          }
          return null;
        },
        routes: [
          GoRoute(
            name: login,
            path: login,
            builder: (context, state) {
              return Loginpage(
                key: state.pageKey,
              );
            },
          ),
          GoRoute(
            name: app,
            path: app,
            builder: (context, state) {
              final userId = state.pathParameters['id'];
              final key = ValueKey(userId);
              return AppPage(
                key: key,
              );
            },
          ),
        ],
      ),
    ],
  );
}
