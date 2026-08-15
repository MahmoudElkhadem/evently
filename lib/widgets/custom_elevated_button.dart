import 'package:flutter/material.dart';


class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
  super.key,
  required this.text,
  this.onPressed,
  required this.isImage,
  this.image,
  required this.backgroundColor,
  required this.foregroundColor
  });


  final String text;
  final void Function()? onPressed;
  final bool isImage;
  final String? image;
  final Color backgroundColor;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        child:
        isImage ?
        Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image!),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
            :
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
