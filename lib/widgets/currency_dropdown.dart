import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CurrencyDropdown extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  const CurrencyDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: currencyList.map((String currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
    );
  }
}
