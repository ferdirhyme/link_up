import 'package:animated_text_field/animated_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

Widget myTextField({
  textController,
  TextInputType? keyboardType,
  Icon? preFixIcon,
  String? hintText,
  errorKey,
  bool? enabled,
  required bool obscure,
  context,
  initialValue,
  required Function ontap,
  Key? key,
  inputformat,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.height / 2,
    child: TextFormField(
      // errorKey: errorKey,

      inputFormatters: inputformat,
      controller: textController,
      keyboardType: keyboardType,
      enabled: enabled,
      obscureText: obscure,
      initialValue: initialValue,
      decoration: InputDecoration(
        label: Text(hintText!),
        prefixIcon: preFixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
      onTap: ontap(),
      validator: (String? value) {
        if (value!.isNotEmpty) {
          if (hintText == 'Password' || hintText == 'Confirm Password') {
            if (!value.hasPasswordLength(length: 6)) {
              return "Password must be at least 6 characters";
            }
          } else if (hintText == 'Email') {
            if (!value.isEmail()) {
              return "Invalid email";
            }
          }
        } else if (value.isEmpty) {
          return 'This Field Cannot be Empty!';
        }
        return null;
      },
    ),
  );
}

Widget myButton({
  required formKey,
  required String label,
  required Function function,
  required Icon icon,
}) {
  return ElevatedButton.icon(
    onPressed: () {
      if (formKey.currentState!.validate()) {
        function();
      }
    },
    icon: icon,
    label: Text(label),
    style: const ButtonStyle(
      iconColor: MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(Colors.green),
      elevation: MaterialStatePropertyAll(10),
      textStyle: MaterialStatePropertyAll(
        TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget datefield({
  key,
  dateController,
  selectedDate,
  context,
  hintText,
  preFixIcon,
  enabled,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.height / 2,
    child: TextFormField(
      readOnly: true,
      enabled: enabled,
      key: key,
      controller: dateController,
      keyboardType: TextInputType.datetime,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        // LengthLimitingTextInputFormatter(8), // Limit to 8 digits (YYYYMMDD)
        // Custom formatter for date
      ],
      decoration: CustomTextInputDecoration(
        fillColor: Colors.white,
        prefixIcon: preFixIcon,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      validator: (String? value) {
        if (value!.isNotEmpty) {
          return null;
        }
        return 'This Field Cannot be Empty!';
      },
      onTap: () async {
        final pickedDate = await showWebDatePicker(
          context: key.currentContext!,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 7)),
          lastDate: DateTime.now().add(const Duration(days: 14000)),
          width: 300,
          withoutActionButtons: true,
          weekendDaysColor: Colors.red,
        );

        if (pickedDate != null) {
          // selectedDate = pickedDate.toString().split(' ')[0];
          dateController.text = pickedDate.toString().split(' ')[0];
        }
      },
    ),
  );
}

Widget myTextArea({
  myTextController,
  label,
  preFixIcon,
  inputformat,
  counter,
  required Function typedCharacterFunction,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextFormField(
      onChanged: (String value) {
        typedCharacterFunction(value);
      },
      minLines: 3,
      maxLines: 10,
      controller: myTextController,
      inputFormatters: inputformat,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        counterText: counter,
        alignLabelWithHint: true,
        prefixIcon: preFixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        labelText: label,
      ),
    ),
  );
}
//  decoration: InputDecoration(
//         label: Text(hintText!),
//         prefixIcon: preFixIcon,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: const BorderSide(
//             color: Colors.black,
//             width: 0.5,
//           ),
//         ),
//       ),