import 'package:flutter/material.dart';

class SciFiTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final ValueChanged<String> onChanged;

  const SciFiTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class SciFiButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isAccent;

  const SciFiButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ), // Android 16 pill
        ),
        backgroundColor: isAccent
            ? theme.colorScheme.secondary
            : theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        disabledBackgroundColor: theme.colorScheme.primary.withOpacity(0.3),
        disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
