import 'package:flutter/material.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';
import 'package:caard_frontend_final/presentation/widgets/custom_buttons.dart';
import 'package:caard_frontend_final/presentation/widgets/custom_text_field.dart';

class RegisterCarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                        )),
                    Text("Register Car Info",
                        textAlign: TextAlign.center,
                        style: KCustomTextstyle.kBold(context, 16)),
                  ],
                ),
                vSizedBox2,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      isPassword: false,
                    validator: null,
                      textInputType: TextInputType.name,
                      hintText: "Vehicle owner name",
                      textEditingController: textEditingController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      isPassword: false,
                    validator: null,
                      textInputType: TextInputType.name,
                      hintText: "Registration number",
                      textEditingController: textEditingController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      isPassword: false,
                    validator: null,
                      textInputType: TextInputType.name,
                      hintText: "Contact number",
                      textEditingController: textEditingController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      isPassword: false,
                    validator: null,
                      textInputType: TextInputType.name,
                      hintText: "Emergency contact",
                      textEditingController: textEditingController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      isPassword: false,
                    validator: null,
                      textInputType: TextInputType.name,
                      hintText: "Alternate contact number",
                      textEditingController: textEditingController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      isPassword: false,
                    validator: null,
                      textInputType: TextInputType.name,
                      hintText: "Car brand",
                      textEditingController: textEditingController),
                ),
                vSizedBox2,
                CustomButtons.roundedCorner(
                    title: "Done",
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: 50,
                    height: 5,
                    textStyle: KCustomTextstyle.kMedium(context, 12),
                    context: context,
                    backgroundColor: KConstantColors.blueColor,
                    cornerRadius: 15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
