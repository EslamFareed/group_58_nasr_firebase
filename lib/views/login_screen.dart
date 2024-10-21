import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  var data =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: "eslam@gmail.com",
                    password: "123456",
                  );

                  if (data.user == null) {
                    print("----- Login Error");
                  } else {
                    print("Login Success");
                    print(data.user!.email);
                    print(data.user!.uid);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var data = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: "ahmed@gmail.com",
                    password: "123456",
                  );

                  if (data.user == null) {
                    print("----- Login Error");
                  } else {
                    print("Login Success");
                    print(data.user!.email);
                    print(data.user!.uid);
                  }
                } catch (e) {
                  String error = e.toString();
                  if (error.contains("email-already-in-use")) {
                    print("You can't use this email");
                  }
                }
              },
              child: Text("Create Account"),
            ),
            ElevatedButton(
              onPressed: () async {
                var data = await signInWithGoogle();
                if (data.user == null) {
                  print("no user selected");
                } else {
                  print("${data.user!.email} Selected");
                }
              },
              child: const Text("Sign in with google"),
            )
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
