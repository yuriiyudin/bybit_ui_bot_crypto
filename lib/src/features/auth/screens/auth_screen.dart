import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 23, 23),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RotatedBox(quarterTurns: 3, child: Lottie.asset('assets/lottie/coin.json')),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome to OctoTrade !',
                  style: GoogleFonts.montserrat(fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  child: Card(
                    child: TextFormField(
                      
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none, prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Card(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none, prefixIcon: Icon(Icons.lock)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {

                    //TODO: Sign in fnc
                  },
                  child: Text('Sign In', style: GoogleFonts.montserrat(
                    fontWeight:  FontWeight.w600
                  ),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
