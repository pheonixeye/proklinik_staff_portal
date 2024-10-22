import 'package:flutter/material.dart';
import 'package:proklinik_staff_portal/components/central_loading.dart';
import 'package:proklinik_staff_portal/components/main_snackbar.dart';
import 'package:proklinik_staff_portal/extensions/loc_ext_fns.dart';

///Shell function encapsulating loading & error handling logic in the UI
Future<void> shellFunction(
  BuildContext context, {
  required Function toExecute,
  String sucessMsg = '',
  Function? onCatch,
  Duration duration = const Duration(seconds: 10),
}) async {
  late BuildContext loadingContext;
  try {
    if (sucessMsg.isEmpty) {
      sucessMsg = context.loc.success;
    }
    if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) {
            loadingContext = context;
            return const CentralLoading();
          });
    }
    await toExecute();
    // await EasyLoading.dismiss();
    if (loadingContext.mounted) {
      Navigator.pop(loadingContext);
    }
    if (context.mounted) {
      showInfoSnackbar(context, sucessMsg);
    }
  } catch (e) {
    // await EasyLoading.dismiss();
    if (loadingContext.mounted) {
      Navigator.pop(loadingContext);
    }
    if (context.mounted) {
      showInfoSnackbar(
        context,
        e.toString(),
        Colors.red,
        duration,
      );
      if (onCatch != null) {
        onCatch();
      }
    }
  }
}
