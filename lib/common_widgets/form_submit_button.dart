import 'package:flutter/material.dart';
import 'package:my_iiit/common_widgets/custom_raised_button.dart';
import 'package:my_iiit/utils/color_utils.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: hexStringToColor("ffb84d"),
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
