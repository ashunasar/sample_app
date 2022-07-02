import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtons {
  static Widget roundedCorner({
    required String title,
    required dynamic onTap,
    required double width,
    required double height,
    required TextStyle textStyle,
    required BuildContext context,
    required Color backgroundColor,
    required double cornerRadius,
    bool? enabled,
  }) {
    return Material(
      color: enabled != null
          ? enabled
              ? backgroundColor
              : Colors.black26
          : backgroundColor,
      borderRadius: BorderRadius.circular(cornerRadius),
      child: InkWell(
        onTap: enabled != null
            ? enabled
                ? onTap
                : null
            : onTap,
        child: SizedBox(
          height: height.h,
          width: width.w,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: textStyle),
            ),
          ),
        ),
      ),
    );
  }
}
