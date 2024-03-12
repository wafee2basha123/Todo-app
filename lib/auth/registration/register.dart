import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/DialogUtls.dart';
import 'package:todoapp/auth/registration/customTextForm.dart';
import 'package:todoapp/homescreen.dart';
import 'package:todoapp/mytheme.dart';

class RegisterScreen extends StatefulWidget {
static const String routeName = 'register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 TextEditingController namecontroller = TextEditingController(text: 'wafeek');

final TextEditingController emailcontroller = TextEditingController(text: 'wafeek@gmail.com' );

final TextEditingController passwordcontroller = TextEditingController(text: '123456');

final TextEditingController confirmPasscontroller = TextEditingController(text: '123456');

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  title: const Text('Create Account'),
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
                  CustomTextFormFeild(label: 'User Name',
                  controller: namecontroller,
                  validator: (text){
                    if (text == null ||  text.trim().isEmpty){
                      return 'please enter username';
                    }
                    return null;

                  },),

                 CustomTextFormFeild(label: 'Email',
                 controller: emailcontroller,
                   keyboardType: TextInputType.emailAddress,
                   validator: (text) {
                     if (text == null || text
                         .trim()
                         .isEmpty) {
                       return 'please enter email';
                     }
                     bool validEmail =
                     RegExp(
                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                         .hasMatch(text);
                     if (!validEmail) {
                       return ' please enter a valid email';
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

                 CustomTextFormFeild(label: 'Confirm password',
                     controller: confirmPasscontroller,
                     obscureText: true,

                     validator: (text){
                       if (text == null ||  text.trim().isEmpty){
                         return 'please confirm password ';
                       }
                       if(text != passwordcontroller.text){
                         return 'password dont match ';
                       }

                           return null;
                     },
                     keyboardType: TextInputType.number),


                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                     onPressed: () {
                       Register(context);
                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: MyTheme.primaryColor,
                     ),
                     child: Text(
                       'Create Account',
                       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: MyTheme.whiteColor),
                     ),
                   ),

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

 void Register(BuildContext context) async {
   if (formKey.currentState?.validate() == true) {
     DialogUtls.showLoading(
       context: context,
       message: 'loading..',
       isDismissible: false,
     );

     try {
       final credential =
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailcontroller.text,
         password: passwordcontroller.text,
       );
       DialogUtls.hideLoading(context); // Hide loading when successful
       DialogUtls.showMessage(
         context: context,
         message: 'Register Successfully',
         title: 'Success',
         posAvtionName: 'Ok',
         posAction: () {
           Navigator.of(context).pushNamed(HomeScreen.routeName);
         },
       );
       print(credential.user?.uid ?? '');
     } on FirebaseAuthException catch (e) {
       DialogUtls.hideLoading(context);
       String errorMessage = '';
       String title = 'Error';
       String? errorCode = e.code;
       switch (errorCode) {
         case 'weak-password':
           errorMessage = 'The password provided is too weak.';
           break;
         case 'email-already-in-use':
           errorMessage = 'The account already exists for that email.';
           break;
         default:
           errorMessage = 'An error occurred: ${e.message}';
       }
       DialogUtls.showMessage(
         context: context,
         message: errorMessage,
         title: title,
         posAvtionName: 'Ok',
       );
       print(errorMessage);
     } catch (e) {
       DialogUtls.hideLoading(context);
       DialogUtls.showMessage(
         context: context,
         message: e.toString(),
         title: 'Error',
         posAvtionName: 'Ok',
       );
       print(e);
     }
   }
 }

}
