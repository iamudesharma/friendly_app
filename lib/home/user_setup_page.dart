import 'package:flutter/material.dart';
import 'package:friendly_app/auth/widgets/custom_text_field.dart';

class UserSetupPage extends StatefulWidget {
  const UserSetupPage({super.key});

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;
  late List<TextEditingController> _linkControllers;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();
    _dobController = TextEditingController();
    _genderController = TextEditingController();
    _linkControllers = [];
    super.initState();
  }

  addMoreLink() {
    setState(() {
      _linkControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Setup'),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500, minWidth: 300),
            child: Column(
              children: [
                CustomTextFieldWidget(
                  controller: _nameController,
                  hintText: "Enter your name",
                  labelText: "Name",
                ),
                CustomTextFieldWidget(
                  controller: _phoneController,
                  hintText: "Enter your phone number",
                  labelText: "Name",
                ),
                CustomTextFieldWidget(
                  controller: _dobController,
                  hintText: "Enter your date of birth",
                  labelText: "Name",
                ),
                CustomTextFieldWidget(
                  controller: _bioController,
                  hintText: "Enter your Bio",
                  labelText: "Name",
                ),
                CustomTextFieldWidget(
                  controller: _nameController,
                  hintText: "Enter your Gender",
                  labelText: "Name",
                ),
                if (_linkControllers.isNotEmpty) ...[
                  for (var i = 0; i < _linkControllers.length; i++)
                    CustomTextFieldWidget(
                      controller: _linkControllers[i],
                      hintText: "Enter your link",
                      labelText: "Name",
                    )
                ],
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    addMoreLink();
                  },
                  label: const Text('add link'),
                )
              ],
            ),
          ),
        ));
  }
}
