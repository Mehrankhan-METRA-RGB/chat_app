import 'package:chat_app/Presentation/common/app_shadow.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool isValid;
  final bool isBorderRequired;
  final String? titleText;
  final int? maxline;
  final String? validateText;
  final bool? isShadowRequired;
  final Color? titleTextColor;
  final double? suffixWidth;
  final double? suffixHeight;
  final ValueChanged? onChanged;
  const AppTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.textInputType,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.isValid = false,
    this.isBorderRequired = true,
    this.titleText = "",
    this.maxline = 1,
    this.validateText,
    this.isShadowRequired = false,
    this.titleTextColor = Colors.black,
    this.suffixWidth = 15,
    this.suffixHeight = 15,
    this.onChanged,
  }) : super(key: key);

  final double borderRadius = 12;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText!.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        titleText!,
                        style: TextStyle(
                          fontSize: 16,
                          color: titleTextColor,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          Container(
            decoration: BoxDecoration(
              boxShadow: isShadowRequired! ? [AppShadow.normal()] : [],
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: isValid
                  ? (v) {
                      if (v!.trim().isEmpty) {
                        return validateText;
                      }
                      return null;
                    }
                  : validator,
              onChanged: onChanged,
              keyboardType: textInputType,
              obscureText: obscureText,
              controller: controller,
              maxLines: maxline,
              style: TextStyle(
                fontSize: 16,
                color: titleTextColor,
              ),
              cursorColor: Colors.blueAccent,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: hintText,
                prefixIcon: prefixIcon != null
                    ? SizedBox(
                        width: 15,
                        height: 15,
                        child: Center(
                          child: prefixIcon,
                        ),
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? SizedBox(
                        width: suffixWidth!,
                        height: suffixHeight!,
                        child: Center(
                          child: suffixIcon,
                        ),
                      )
                    : null,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: prefixIcon != null ? 0 : 20,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius,
                  ),
                  borderSide: BorderSide(
                    color: isBorderRequired ? Colors.red : Colors.transparent,
                  ),
                ),
                errorBorder: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      )
                    : outlineInputBorder(),
                border: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                      )
                    : outlineInputBorder(),
                focusedBorder: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ),
                      )
                    : outlineInputBorder(),
                enabledBorder: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      )
                    : outlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
