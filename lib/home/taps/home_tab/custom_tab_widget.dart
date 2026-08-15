import 'package:evently/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  const CustomTabWidget({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.icon,
  });

  final bool isSelected;
  final String eventName;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor
        : Theme.of(context).hoverColor
        ,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 5,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColor.inputsLightMode
            : Theme.of(context).primaryColor,
          ),
          Text(
            eventName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColor.inputsLightMode
            : Theme.of(context).splashColor,
          ),
          )
        ],
      ),
    );
  }
}
