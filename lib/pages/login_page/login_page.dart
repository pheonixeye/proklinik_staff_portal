import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_staff_portal/assets/assets.dart';
import 'package:proklinik_staff_portal/extensions/loc_ext_fns.dart';
import 'package:proklinik_staff_portal/functions/shell_function.dart';
import 'package:proklinik_staff_portal/providers/px_app_users.dart';
import 'package:proklinik_staff_portal/routes/routes.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  bool rememberMe = false;
  bool obscure = true;
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            children: [
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                height: 100,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(Assets.icon),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                context.loc.proklinik,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Text("@"),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        key: _emailFieldKey,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: context.loc.email,
                          hintText: "example@domain.com",
                          border: const OutlineInputBorder(),
                          suffix: const SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              !EmailValidator.validate(value)) {
                            return context.loc.enterValidEmail;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.password),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: context.loc.password,
                          hintText: "********",
                          border: const OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 32,
                            child: FloatingActionButton.small(
                              heroTag: 'obscure-password',
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            ),
                          ),
                        ),
                        obscureText: obscure,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.loc.kindlyEnterPassword;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<PxAppUsers>(
                builder: (context, u, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24,
                    ),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      label: Text(context.loc.login),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            EmailValidator.validate(_emailController.text)) {
                          await shellFunction(
                            context,
                            toExecute: () async {
                              final id = await u.loginUserByEmailAndPassword(
                                _emailController.text,
                                _passwordController.text,
                              );
                              if (context.mounted) {
                                GoRouter.of(context).goNamed(
                                  AppRouter.app,
                                  pathParameters: {'id': id!},
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 4.0,
                ),
                child: Consumer<PxAppUsers>(
                  builder: (context, u, _) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.lock_reset),
                      label: Text(context.loc.forgotPassword),
                      onPressed: () async {
                        //todo: email field is not empty
                        if (_emailFieldKey.currentState != null &&
                            _emailFieldKey.currentState!.validate() &&
                            EmailValidator.validate(_emailController.text)) {
                          await shellFunction(
                            context,
                            toExecute: () async {
                              await u.requestPasswordReset(
                                  _emailController.text.trim());
                            },
                            sucessMsg: context.loc.linkSentToEmail,
                            duration: const Duration(seconds: 15),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
