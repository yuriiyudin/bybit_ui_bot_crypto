import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLogoWidget extends StatelessWidget {
  const MainLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Octopus Terminal',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white, shadows: [
            const Shadow(
              offset: Offset(0, 3.0),
              blurRadius: 3,
              color: Color.fromARGB(255, 17, 161, 176),
            )
          ])),
      TextSpan(
        text: ' trade',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          fontSize: 19,
          color: Colors.blueGrey,
        ),
      ),
      TextSpan(
        text: ' v. 0.0.4',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.blueGrey,
        ),
      ),
    ]));
  }
}
