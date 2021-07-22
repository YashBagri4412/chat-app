import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickerFn;
  UserImagePicker(this.imagePickerFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final picker = ImagePicker();
  File _image;

  void _getImage() async {
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 200,
      maxHeight: 500,
    );

    setState(() {
      _image = File(pickedImageFile.path);
    });
    widget.imagePickerFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        FlatButton.icon(
          onPressed: _getImage,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
