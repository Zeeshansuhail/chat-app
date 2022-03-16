import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageShow extends StatefulWidget {
  ImageShow(this.pickedfile);
  final Function(File picked) pickedfile;

  @override
  State<ImageShow> createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {
  File _pickedImage;
  void _pickImage() async {
    final getimage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    setState(() {
      _pickedImage = File(getimage.path);
    });
    widget.pickedfile(File(getimage.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: () {
            _pickImage();
          },
          icon: Icon(Icons.image),
          label: Text(
            "Add image",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
