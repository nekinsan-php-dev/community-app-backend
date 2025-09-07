import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(String value, int index) onChanged;
  final Function(int index) onBackspace;

  const OtpInputFields({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return _buildOtpField(index);
      }),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: focusNodes[index].hasFocus
              ? const Color(0xFF6366F1)
              : Colors.grey[300]!,
          width: focusNodes[index].hasFocus ? 2 : 1,
        ),
        color: focusNodes[index].hasFocus
            ? const Color(0xFF6366F1).withOpacity(0.05)
            : Colors.grey[50],
      ),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) => onChanged(value, index),
        onTap: () {
          // Select all text when tapped
          controllers[index].selection = TextSelection.fromPosition(
            TextPosition(offset: controllers[index].text.length),
          );
        },
        onEditingComplete: () {
          // Handle backspace when field is empty
          if (controllers[index].text.isEmpty && index > 0) {
            onBackspace(index);
          }
        },
      ),
    );
  }
}
