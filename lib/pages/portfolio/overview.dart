import 'dart:io';
import 'package:fk_toggle/fk_toggle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:gap/gap.dart';
import 'package:page_route_animator/page_route_animator.dart';

import '../../constants/widgets.dart';
import '../../uploadData/data.dart';
import 'statements.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _taglineController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late TextEditingController dobController = TextEditingController();

  String? userId;
  Uint8List? selectedImageBytes;
  Map pupilData = {};
  String imageUrl = '';

  bool loading = false;
  dynamic firstImage;

  String logoPhoto = 'Please Upload a Profile Image';
  String nameofuser = 'Name';
  bool userIcon = true;
  final dobFieldKey = GlobalKey();
  bool showBusinessWidget = false;

  late DateTime _selectedDOB = DateTime.now();

  Widget business() {
    return Column(
      children: [
        myTextField(
          obscure: false,
          ontap: () {},
          context: context,
          hintText: nameofuser,
          keyboardType: TextInputType.text,
          textController: _nameController,
          preFixIcon: userIcon ? const Icon(Icons.person) : const Icon(Icons.business),
        ),
        const Gap(10),
        myTextField(
          obscure: false,
          ontap: () {},
          context: context,
          hintText: 'Email',
          keyboardType: TextInputType.text,
          textController: _emailController,
          preFixIcon: const Icon(Icons.email),
        ),
        const Gap(10),
        myTextField(
          obscure: false,
          ontap: () {},
          context: context,
          hintText: 'Tag Line',
          enabled: showBusinessWidget,
          keyboardType: TextInputType.text,
          textController: _taglineController,
          preFixIcon: const Icon(Icons.format_quote),
        ),
        const Gap(10),
        datefield(
          enabled: showBusinessWidget,
          context: context,
          dateController: dobController,
          hintText: 'Date Established',
          preFixIcon: const Icon(Icons.date_range),
          selectedDate: _selectedDOB,
          key: dobFieldKey,
        ),
      ],
    );
  }

  Widget personal() {
    return Column(
      children: [
        myTextField(
          obscure: false,
          ontap: () {},
          context: context,
          hintText: nameofuser,
          keyboardType: TextInputType.text,
          textController: _nameController,
          preFixIcon: userIcon ? const Icon(Icons.person) : const Icon(Icons.business),
        ),
        const Gap(10),
        myTextField(
          obscure: false,
          ontap: () {},
          context: context,
          hintText: 'Email',
          keyboardType: TextInputType.text,
          textController: _emailController,
          preFixIcon: const Icon(Icons.email),
        ),
        const Gap(20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            FkToggle(
              disabledElementColor: Colors.grey,
              selectedColor: Colors.green,
              width: MediaQuery.of(context).size.height / 5,
              height: 40,
              labels: const ['PERSONAL', 'BUSINESS'],
              icons: const [Icon(Icons.person), Icon(Icons.business)],
              onSelected: (idx, instance) {
                if (idx == 0) {
                  setState(() {
                    logoPhoto = 'Please Upload a Profile Image';
                    nameofuser = 'Name';
                    userIcon = true;
                    showBusinessWidget = false;
                  });
                } else {
                  setState(() {
                    logoPhoto = 'Please Upload your Business Logo';
                    nameofuser = 'Business Name';
                    userIcon = false;
                    showBusinessWidget = true;
                  });
                }
              },
            ),
            const Gap(20),
            FormBuilderImagePicker(
              iconColor: Colors.green,
              onChanged: (List<dynamic>? selectedImages) async {
                if (selectedImages != null && selectedImages.isNotEmpty) {
                  setState(() {
                    firstImage = selectedImages[0];
                  });

                  if (firstImage is XFile) {
                    // Convert XFile to Uint8List
                    selectedImageBytes = await File(firstImage.path).readAsBytes();
                    // debugPrint("Selected Image Bytes: $selectedImageBytes");
                  } else {
                    EasyLoading.showError("Invalid image type. Expected XFile, received: $firstImage");
                  }
                }
              },
              name: 'singleAvatarPhoto',
              decoration: const InputDecoration(
                labelText: 'Pick Photos',
              ),
              transformImageWidget: (context, displayImage) => Card(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.expand(
                  child: displayImage,
                ),
              ),
              showDecoration: false,
              maxImages: 1,
              previewAutoSizeWidth: false,
            ),
            Text(logoPhoto),
            const Gap(20),
            userIcon ? personal() : business(),
            const Gap(20),
            myButton(
              formKey: formKey,
              label: 'Next',
              function: () {
                data['username'] = _nameController.text;
                data['email'] = _emailController.text;
                data['tagline'] = _taglineController.text;
                data['dateEstablished'] = _selectedDOB.toString().split(' ')[0];
                Navigator.push(
                  context,
                  PageRouteAnimator(
                    child: const Statements(),
                    routeAnimation: RouteAnimation.bottomLeftToTopRight,
                    settings: const RouteSettings(arguments: ''),
                    curve: Curves.easeOut,
                  ),
                );
              },
              icon: const Icon(Icons.navigate_next),
            )
          ],
        ),
      ),
    );
  }
}
