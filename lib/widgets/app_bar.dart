import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/profile/profile_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool withBackButton;

  CustomAppBar({Key? key, required this.withBackButton})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: withBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProfileView(),
              ),
            );
          },
          child: ClipOval(
            child: Image.asset(
              'assets/avatar.png',
              fit: BoxFit.cover,
              width: 40.0,
              height: 40.0,
            ),
          ),
        ),
      ),
      title: Text("Auto Farm",style:  GoogleFonts.dancingScript()),
      centerTitle: true,
      actions:  [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              width: 40.0,
              height: 40.0,
            ),
          ),
        ),
      ],
    );
  }
}
