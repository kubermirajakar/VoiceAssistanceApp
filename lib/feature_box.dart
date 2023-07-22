import 'package:flutter/material.dart';
import 'package:voice_assistance_app/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String description;
  final String text;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.text,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                  color: Pallete.blackColor,
                  fontFamily: 'Cera Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: TextStyle(
              color: Pallete.blackColor,
              fontFamily: 'Cera Pro',
            ),
          ),
        ],
      ),
    );
  }
}
