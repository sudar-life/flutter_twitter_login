import 'package:flutter/material.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('Login With Twitter'),
          onPressed: () async {
            final twitterLogin = TwitterLogin(
              apiKey: '6WljNjSyIZSdr1rfguAU95coi',
              apiSecretKey:
                  'vdlJeJn9QPVddcQCQbx5550tfmch61jvOMjTbubLnJa63LQ2Ib',
              redirectURI: 'twittersdk://',
              // redirectURI: 'twitterkit-6WljNjSyIZSdr1rfguAU95coi://',
            );
            AuthResult authResult = await twitterLogin.login();
            switch (authResult.status) {
              case TwitterLoginStatus.loggedIn:
                final AuthCredential twitterAuthCredential =
                    TwitterAuthProvider.credential(
                        accessToken: authResult.authToken,
                        secret: authResult.authTokenSecret);

                // Once signed in, return the UserCredential
                return await FirebaseAuth.instance
                    .signInWithCredential(twitterAuthCredential);
                // success
                break;
              case TwitterLoginStatus.cancelledByUser:
                // cancel
                break;
              case TwitterLoginStatus.error:
                print(authResult.errorMessage);
                // error
                break;
            }
          },
        ),
      ),
    );
  }
}
