import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  final double spacing;

  const HeaderWidget({
    Key? key,
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: spacing),
      child: Row(
        children: [
          // Menu Icon
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF087A84),
                size: 24,
              ),
            ),
          ),

          // Title (with dynamic spacing)
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: spacing),
              child: const Text(
                '   SECP       XS       Mobile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF087A84),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  letterSpacing: -0.4,
                  height: 3.4,
                ),
              ),
            ),
          ),

          // Profile Image
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/XS.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
    );
  }
}