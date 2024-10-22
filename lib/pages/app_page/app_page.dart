import 'package:flutter/material.dart';
import 'package:proklinik_staff_portal/providers/px_app_users.dart';
import 'package:provider/provider.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.read<PxAppUsers>().model!.token),
      ),
    );
  }
}
