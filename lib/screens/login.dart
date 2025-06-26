import 'package:chat_app/constant/app_router.dart';
import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/image_pathes.dart';
import 'package:chat_app/widgets/custom_buttom.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Center(child: Image.asset(ImagePathes.logo)),
                CustomText(
                  color: TextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  text: "Scholar Chat",
                ),
                SizedBox(height: 10.h),

                Row(
                  children: [
                    SizedBox(width: 2.w),
                    CustomText(
                      color: TextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      text: "Sign In",
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: "Email",
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomTextField(
                    hintText: "Password",
                    isObscure: true,
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButtom(
                    text: "Login",
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          context.push(AppRouter.chatPath,extra: email);
                          showSnackBar(
                            context,
                            'The email Created Successfully',
                            Colors.green,
                          );
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                              context,
                              'No user found for that email.',
                              Colors.red,
                            );
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                              context,
                              'Wrong password provided for that user.',
                              Colors.red,
                            );
                          }
                        } catch (e) {
                          showSnackBar(context, 'The is an error', Colors.grey);
                        }
                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                  ),
                ),
                SizedBox(height: 1.h),

                InkWell(
                  onTap: () {
                    context.push(AppRouter.registerPath);
                  },
                  child: CustomText(
                    color: kColor,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    text: "Don't have an account? Sign Up ",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
