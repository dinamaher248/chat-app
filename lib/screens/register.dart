import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/image_pathes.dart';
import 'package:chat_app/widgets/custom_buttom.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

import '../constant/app_router.dart' show AppRouter;
import '../helper/show_snack_bar.dart';
import '../widgets/custom_text_field.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

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

                //  Spacer(flex: 2),
                Center(child: Image.asset(ImagePathes.logo)),
                CustomText(
                  color: TextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  text: "Scholar Chat",
                ),
                SizedBox(height: 10.h),
                //Spacer(flex: 1),
                Row(
                  children: [
                    SizedBox(width: 2.w),
                    CustomText(
                      color: TextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      text: "Sign UP",
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
                    // isObscure: true,
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButtom(
                    text: "Register",
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await RegisterUser();
                          context.push(AppRouter.chatPath,extra: email);

                          showSnackBar(
                            context,
                            'The email Created Successfully',Colors.green
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                              context,
                              'The password provided is too weak.',Colors.grey
                            );
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(
                              context,
                              'The account already exists for that email.',Colors.red
                            );
                          }
                          print(e);
                        } catch (e) {
                          showSnackBar(context, 'The is an error',Colors.red);
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
                    context.push(AppRouter.loginPath);
                  },
                  child: CustomText(
                    color: kColor,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    text: "Don't have an account? Sign In ",
                  ),
                ),
                // Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Future<void> RegisterUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
