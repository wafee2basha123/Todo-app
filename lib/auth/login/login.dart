import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/auth/registration/customTextForm.dart';
import 'package:todoapp/auth/registration/register.dart';
import 'package:todoapp/mytheme.dart';

import '../../DialogUtls.dart';
import '../../homescreen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';

 final TextEditingController emailcontroller = TextEditingController(text:  'wafeek44@gmail.com');
  final TextEditingController passwordcontroller = TextEditingController(text: '123456');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.backgroundLightColor,
          child: Image.asset('assets/Images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Login'),
            centerTitle:  true,
            backgroundColor: Colors.transparent,

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text('Welcome Back',
                         style:  Theme.of(context).textTheme.titleMedium,),
                       ),


                      CustomTextFormFeild(label: 'Email',
                        controller: emailcontroller,
                        validator: (text){
                          if (text == null ||  text.trim().isEmpty){
                            return 'please enter your Email';
                          }
                          return null;

                        },),


                      CustomTextFormFeild(label: 'Password',
                        controller: passwordcontroller,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (text){
                          if (text == null ||  text.trim().isEmpty){
                            return 'please enter password';

                          }
                          if (text.length < 6){

                            return ' password should be more than 6 char';
                          }
                          return null;

                        },
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Login(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.primaryColor,
                          ),
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: MyTheme.whiteColor),
                          ),
                        )

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(onPressed: (){
                          Navigator.of(context).pushNamed(RegisterScreen.routeName);
                        },
                            child: Text('Or Create Account ',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                      )
                    ],
                  ),)
              ],
            ),
          ),
        )
      ],
    );
  }

  void Login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogUtls.showLoading(
        context: context,
        message: 'loading..',
        isDismissible: false,
      );

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );

        DialogUtls.hideLoading(context); // Hide loading when successful login
        Navigator.of(context).pushNamed(HomeScreen.routeName); // Navigate to home screen
        print('login successful');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        DialogUtls.hideLoading(context); // Hide loading on exception
        if (e.code == 'invalid-credential') {
          DialogUtls.showMessage(
            context: context,
            message: 'The supplied auth credential is incorrect, malformed, or has expired.',
          );
          print('The supplied auth credential is incorrect, malformed, or has expired.');
        }
      } catch (e) {
        DialogUtls.hideLoading(context); // Hide loading on exception
        print(e.toString());
      }
    }
  }


}
