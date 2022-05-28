import 'package:flutter/material.dart';
import 'package:tiktoc_clone_app/constants.dart';

import 'package:tiktoc_clone_app/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'TikTok Clone',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: buttonColor),
                ),
                Text(
                  'Register',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.grey,
                      //   backgroundImage: NetworkImage(
                      //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvIDopi4W37sg8SNxY9H3sXNTY-CR6mvWZ-P72A0erk0woLczllUnBfTcuIu9ObZR2R2c&usqp=CAU'),
                      //
                    ),
                    Positioned(
                      bottom: -10,
                      left: 85,
                      child: IconButton(
                        onPressed: () => authController.pickImage(),
                        
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                      controller: _userNameController,
                      labelText: 'UserName',
                      isObscure: false,
                      icon: Icons.person),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _emailController,
                    labelText: 'Email',
                    isObscure: false,
                    icon: Icons.email,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _passwordController,
                    labelText: 'Password',
                    isObscure: true,
                    icon: Icons.lock,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: InkWell(
                    // onTap: () => authController.registerUser(
                    //     _userNameController.text,
                    //     _emailController.text,
                    //     _passwordController.text,
                    //     authController.profilePhoto),

                    onTap: () => authController.registerUser(
                      
                      _userNameController.text.trim(),
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      authController.profilePhoto,
                    ),

                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('Ok');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: buttonColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
