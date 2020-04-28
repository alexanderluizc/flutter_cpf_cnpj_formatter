import 'package:flutter/services.dart';

class CPFCNPJInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;

    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength == 4 && newValue.text.substring(3) != '.') {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) +
          '.' +
          newValue.text.substring(4));
      if (newValue.selection.end >= 4) selectionIndex += 1;
    }

    if (newTextLength == 8 && newValue.text.substring(7) != '.') {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 7) +
          '.' +
          newValue.text.substring(8));
      if (newValue.selection.end >= 8) selectionIndex += 1;
    }

    if (newTextLength == 12 && newValue.text.substring(11) != '-') {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 11) +
          '-' +
          newValue.text.substring(12));
      if (newValue.selection.end >= 12) selectionIndex += 1;
    }

    // CPF
    if (newTextLength == 14) {
      usedSubstringIndex = 14;
      final textWithoutSeparators =
          newValue.text.replaceAll(new RegExp("[-./]"), "");
      newText.write(textWithoutSeparators.substring(0, 3) +
          '.' +
          textWithoutSeparators.substring(3, 6) +
          '.' +
          textWithoutSeparators.substring(6, 9) +
          '-' +
          textWithoutSeparators.substring(9, 11));
      if (newValue.selection.end >= 15) selectionIndex += 1;
    }

    // CNPJ
    if (newTextLength == 15) {
      usedSubstringIndex = 15;
      final textWithoutSeparators =
          newValue.text.replaceAll(new RegExp("[-./]"), "");
      newText.write(textWithoutSeparators.substring(0, 2) +
          '.' +
          textWithoutSeparators.substring(2, 5) +
          '.' +
          textWithoutSeparators.substring(5, 8) +
          '/' +
          textWithoutSeparators.substring(8, 12));
    }

    if (newTextLength == 16 && newValue.text.substring(15) != '-') {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 15) +
          '-' +
          newValue.text.substring(16));
      if (newValue.selection.end >= 16) selectionIndex += 1;
    }

    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));

    return TextEditingValue(
      text: newTextLength < 19 ? newText.toString() : oldValue.text.toString(),
      selection: TextSelection.collapsed(
        offset: newTextLength < 19 ? selectionIndex : newTextLength - 1,
      ),
    );
  }
}
