import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimalstore/components/login_button.dart';
import 'package:minimalstore/components/my_text_field.dart';
import 'package:minimalstore/components/square_tile.dart';
import 'package:minimalstore/pages/forgot_password.dart';
import 'package:minimalstore/pages/shop_page.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShopPage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
       title: const Text("Login"),
       backgroundColor: Colors.transparent,
       elevation: 0,
      ),
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(Icons.lock, size: 100),

              const SizedBox(height: 50),

              // texto de boas vindas ao usuário
              Text(
                "Que bom que você voltou!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16),
              ),
              const SizedBox(height: 25),

              MyTextField(
                  controller: emailController,
                  hintText: "Digite seu e-mail", 
                  obscureText: false),
                  
              const SizedBox(height: 10),

              MyTextField(
                  controller: passwordController, 
                  hintText: "Digite sua senha", 
                  obscureText: true),
              const SizedBox(height: 10),

                // esqueceu a senha 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, 
                             MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: Text("Esqueceu sua senha?",
                          style: TextStyle(color: Colors.grey.shade600)),
                      )
                    ])),
                const SizedBox(height: 25),
                // Botão Logar
                LoginButton(onTap: signUserIn, text: "Entrar"),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        )),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("ou",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary
                  )
                  )),

                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400]
                  ))

                 ],
                 )),
           const SizedBox(height: 25),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquareTile(
                imagePath: "https://firebasestorage.googleapis.com/v0/b/projetoflutter-42ffa.appspot.com/o/google.jpeg?alt=media&token=2e19d209-d029-4a19-9ba2-460709c991f0", 
                 onTap: (){},
                ),
              const SizedBox(width: 25),
              SquareTile(
                imagePath: "https://firebasestorage.googleapis.com/v0/b/projetoflutter-42ffa.appspot.com/o/apple.jpeg?alt=media&token=04a8ef48-30ca-4143-9a9b-8113ab03e642", 
                 onTap: (){}
                )
            ]),
            const SizedBox(height: 25),
            // Texto Crie sua conta 
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ainda não possui conta?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary
                    )
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, 
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      "Registre-se",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ]
              ),
              )


            ]),
        ),
      )
    )
   );
  }
}