import 'package:flutter/material.dart';
import 'package:friendly_app/helpers/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationPermission checkPermissionValue;

  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    var _checkPermission = await Geolocator.checkPermission();

    await checkPermissionData(_checkPermission);
    setState(() {
      _isLoading = false;
      checkPermissionValue = _checkPermission;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _isLoading
              ? CircularProgressIndicator.adaptive()
              : checkPermission(checkPermissionValue)),
    );
  }
}
