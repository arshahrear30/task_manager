import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key, this.enableOnTap = true});

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = const Base64Decoder().convert(AuthController.user?.photo ?? '');

    return ListTile(
      onTap: () {
        if (enableOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
          );
        }
      },

      leading: CircleAvatar(
        child: AuthController.user?.photo == null //picture asey kina check dicci
            ? const Icon(Icons.person) //picture na thakley person er pic
            : ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          ),
        ),
      ),


      title: Text(
        fullName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '', //auth thekey email ta o nilam
        style: TextStyle(color: Colors.white),
      ),

      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          Navigator.pushAndRemoveUntil(
            //dekho akta warning acey eta stafull use korley coila jaibo.. eta HW
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        },

        icon: const Icon(Icons.logout),
      ),

      tileColor: Colors.green,
    );
  }

  String get fullName {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ')'}';
  }
}
