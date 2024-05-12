
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploaderView extends StatefulWidget {
  const UploaderView({super.key});

  @override
  State<UploaderView> createState() => _UploaderViewState();
}

class _UploaderViewState extends State<UploaderView> {
  String fileName = "";

  // void selectFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(fileName),
          TextButton(
            child: Text("Select File"),
            onPressed: () {
              // selectFile();
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Upload"),
          )
        ],
      ),
    );
  }
}
