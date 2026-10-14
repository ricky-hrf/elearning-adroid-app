import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final String? hint;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.textInputAction,
    this.onSubmitted,
  });

  static const double radius = 100;
  static const Color primaryColor = Color(0xFF4A90D9);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure = widget.isPassword;

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTextField.radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: Colors.grey.shade900),
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.prefixIcon),
        prefixIconColor: AppTextField.primaryColor,
        suffixIconColor: AppTextField.primaryColor,
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
        )
            : null,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: _border(AppTextField.primaryColor),
        enabledBorder: _border(AppTextField.primaryColor),
        focusedBorder: _border(AppTextField.primaryColor, width: 2),
        errorBorder: _border(Colors.red.shade700),
        focusedErrorBorder: _border(Colors.red.shade700, width: 2),
      ),
    );
  }
}