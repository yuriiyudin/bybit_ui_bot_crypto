import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terminal_octopus/src/features/dashboard/signals/signals_screen.dart';
import 'package:terminal_octopus/src/routes/named_route.dart';

class MenuButton extends StatefulWidget {
  MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.location,
    this.color1 = const Color.fromARGB(255, 51, 8, 78),
    this.color2 = const Color.fromARGB(255, 209, 250, 230),
  });

  final String title;
  final IconData icon;
  final String location;
  final Color color1;
  final Color color2;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  var glowing = false;
  Color defaultColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          glowing = true;
        });
      },
      onExit: (event) {
        setState(() {
          glowing = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          if (widget.location == MyAppRouteConstants.homeRouteName) {
            GoRouter.of(context).pushReplacementNamed(
              widget.location,
            );
          } else {
            GoRouter.of(context).pushNamed(
              widget.location,
            );
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: glowing
                ? [
                    BoxShadow(color: widget.color1.withOpacity(0.1), spreadRadius: 1, blurRadius: 8, offset: Offset(-8, 0)),
                    BoxShadow(color: widget.color2.withOpacity(0.1), spreadRadius: 1, blurRadius: 8, offset: Offset(8, 0)),
                    BoxShadow(color: widget.color1.withOpacity(0.1), spreadRadius: 8, blurRadius: 16, offset: Offset(-8, 0)),
                    BoxShadow(color: widget.color2.withOpacity(0.1), spreadRadius: 8, blurRadius: 16, offset: Offset(8, 0)),
                  ]
                : [],
          ),
          child: ListTile(
            leading: Icon(
              widget.icon,
              size: 30,
              color: glowing ? Colors.greenAccent : defaultColor,
            ),
            title: Text(
              widget.title,
              style: GoogleFonts.slabo27px(
                color: glowing ? Colors.greenAccent : defaultColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
