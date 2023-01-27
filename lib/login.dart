import 'package:brand_maps/admin/admin_home.dart';
import 'package:brand_maps/controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raised_buttons/raised_buttons.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: double.infinity,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: const <Widget>[
                      Text(
                        'Hallo.',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Divider(
                          thickness: 3,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                  const Text(
                    'Admin',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 36,
                        letterSpacing: 5),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: emailC,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: passwordC,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  await AuthService()
                                      .signIn(emailC.text, passwordC.text);
                                  if (await FirebaseAuth
                                          .instance.currentUser?.uid !=
                                      null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminHome(),
                                            maintainState: true));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'Periksa Email&Password'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            ));

                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(8),
                                    // ),
                                    // color: Color(0xFF4f4f4f),
                                    // elevation: 0,
                                    // padding: EdgeInsets.symmetric(vertical: 16),
                                  }
                                })),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  // color: Colors.white,
                  // elevation: 0,
                  // padding: EdgeInsets.symmetric(vertical: 16),

                  const SizedBox(height: 8),

                  const SizedBox(height: 30),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Dont have account ?',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Register here',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
