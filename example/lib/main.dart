import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imagelib;
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
    home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String fileName = "";
  List<Filter> filters = presetFiltersList;
  final picker = ImagePicker();
  File? imageFile;

  Future getImage(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      fileName = basename(imageFile!.path);
      var image = imagelib.decodeImage(await imageFile!.readAsBytes());
      image = imagelib.copyResize(image!, width: 600);
      Map imagefile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoFilterSelector(
            title: const Text("Пример фотофильтра"),
            image: image!,
            filters: presetFiltersList,
            filename: fileName,
            loader: const Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (imagefile.containsKey('image_filtered')) {
        setState(() {
          imageFile = imagefile['image_filtered'];
        });
        debugPrint(imageFile!.path);
      }
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Обработка изображения фильтрами'),
//       ),
//       body: Center(
//         child: Container(
//           child: imageFile == null
//               ? const Center(
//                   child: Text('No image selected.'),
//                 )
//               : Image.file(File(imageFile!.path)),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => getImage(context),
//         tooltip: 'Pick Image',
//         child: const Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Обработка изображения фильтрами'),
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(30),
              child: Center(
                child: Text(
                    "IsMoiL Sheraliev \n Разработка приложения \n «Обработка изображения фильтрами» \n Курсавой работа" ,style:
                TextStyle(color:Colors.teal,fontSize: 18, fontStyle: FontStyle.normal ),
                ),
              )
          ),
          SizedBox(width: 23, height: 100,),
          Center(
            child: Container(
              child: imageFile == null
                  ? const Center(
                child: Text('Изображение не выбрано.'),
              )
                  : Image.file(File(imageFile!.path)),

            ),
          ),

        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Выберите изображение',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
