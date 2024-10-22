import 'package:proklinik_staff_portal/api/app_user_api/app_user_api.dart';
import 'package:proklinik_staff_portal/providers/px_app_users.dart';
import 'package:proklinik_staff_portal/providers/px_locale.dart';
import 'package:proklinik_staff_portal/providers/px_theme.dart';
import 'package:proklinik_staff_portal/services/local_database_service/local_database_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocalDatabase.instance),
  ChangeNotifierProvider(create: (context) => PxLocale(context)),
  ChangeNotifierProvider(create: (context) => PxTheme(context)),
  ChangeNotifierProvider(
    create: (context) => PxAppUsers(
      userService: const HxAppUsers(),
    ),
  ),
];
