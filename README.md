Пакет фотофильтров для флаттера
ИсМоиЛ Шералиев Курсовая работа Разработка приложения «Обработка изображения фильтрами»
Пакет flutter для iOS и Android для применения фильтра к изображению. Также доступен набор предустановленных фильтров. Вы также можете создавать свои собственные фильтры.

Монтаж
Сначала добавьте photofiltersи imageв качестве зависимости в файл pubspec.yaml .

iOS
Никакой настройки не требуется — плагин должен работать «из коробки».

Андроид
Никакой настройки не требуется — плагин должен работать «из коробки».

Пример
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
Снимки экрана пользовательского интерфейса


Примеры изображений фильтров
Нет фильтра Нет фильтра	ЗахватывающийСиний ЗахватывающийСиний	ЗахватывающийКрасный ЗахватывающийКрасный	Аден Аден
Амаро Амаро	Эшби Эшби	Браннан Браннан	Бруклин Бруклин
Подвески Подвески	Кларендон Кларендон	Крема Крема	Патч Патч
Ранняя пташка Ранняя пташка	1977 год 1977 год	Зонтик Зонтик	Гиндза Гиндза
Хефе Хефе	Елена Елена	Хадсон Хадсон	Чернильница Чернильница
Юнона Юнона	Кельвин Кельвин	Жаворонок Жаворонок	Лоу-фай Лоу-фай
Людвиг Людвиг	Мавен Мавен	Мейфэр Мейфэр	Луна Луна
Нэшвилл Нэшвилл	Перпетуя Перпетуя	Рейес Рейес	Рост Рост
Сьерра Сьерра	Горизонт Горизонт	сон сон	Стинсон Стинсон
Сутро Сутро	Тостер Тостер	Валенсия Валенсия	Вечерня Вечерня
Уолден Уолден	Ива Ива	Икс-Про II Икс-Про II	
Примеры изображений фильтров свертки
Личность Личность	Тиснение Тиснение	Заточка Заточка	Обнаружение цветных краев Обнаружение цветных краев
Размытие Размытие	Средство обнаружения краев Средство обнаружения краев	Обнаружение края жесткое Обнаружение края жесткое	Гуасовское размытие Гуасовское размытие
НЧ НЧ	Высокая частота Высокая частота	Иметь в виду Иметь в виду	
Фильтры
Существует два типа фильтров. ImageFilterи ColorFilter.

Фильтр изображений
Фильтр изображений применяет свои подфильтры один за другим непосредственно ко всему изображению. Это требует больших вычислительных затрат, поскольку сложность и время увеличиваются по мере увеличения количества подфильтров.

Вы можете создать свой собственный фильтр изображений следующим образом:

    import 'package:photofilters/filters/image_filters.dart';

    var customImageFilter = new ImageFilter(name: "Custom Image Filter");
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      coloredEdgeDetectionKernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      gaussian7x7Kernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      sharpenKernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      highPass3x3Kernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      lowPass3x3Kernel,
    ));
    customImageFilter.subFilters.add(SaturationSubFilter(0.5));
Вы также можете наследовать класс ImageFilter, чтобы создать еще один фильтр изображений.

class MyImageFilter extends ImageFilter {
  MyImageFilter(): super(name: "My Custom Image Filter") {
    this.addSubFilter(ConvolutionSubFilter.fromKernel(sharpenKernel));
  }
}
Цветовой фильтр
Цветовой фильтр применяет свои подфильтры к каждому пикселю один за другим. В вычислительном отношении он требует меньше затрат, чем ImageFilter. Он будет перебирать пиксели изображения только один раз, независимо от количества подфильтров.

Вы можете создать свой собственный цветовой фильтр следующим образом:

    import 'package:photofilters/filters/color_filters.dart';

    var customColorFilter = new ColorFilter(name: "Custom Color Filter");
    customColorFilter.addSubFilter(SaturationSubFilter(0.5));
    customColorFilter
        .addSubFilters([BrightnessSubFilter(0.5), HueRotationSubFilter(30)]);
Вы также можете наследовать класс ColorFilter.

class MyColorFilter extends ColorFilter {
  MyColorFilter() : super(name: "My Custom Color Filter") {
    this.addSubFilter(BrightnessSubFilter(0.8));
    this.addSubFilter(HueRotationSubFilter(30));
  }
}
Подфильтры
Существует два типа субфильтров. Один можно добавить в файл, ColorFilterа другой — в файл ImageFilter. Вы можете наследовать ColorSubFilterкласс для реализации первого и использовать ImageSubFilterпримесь для реализации второго. Вы можете создать один и тот же подфильтр, который можно использовать как для фильтров изображений, так и для цветных фильтров. Это BrightnessSubFilterпример этого.

class BrightnessSubFilter extends ColorSubFilter with ImageSubFilter {
  final num brightness;
  BrightnessSubFilter(this.brightness);

  ///Apply the [BrightnessSubFilter] to an Image.
  @override
  void apply(Uint8List pixels, int width, int height) =>
      image_filter_utils.brightness(pixels, brightness);

  ///Apply the [BrightnessSubFilter] to a color.
  @override
  RGBA applyFilter(RGBA color) =>
      color_filter_utils.brightness(color, brightness);
}
Начиная
Чтобы получить помощь по началу работы с Flutter, просмотрите нашу онлайн- документацию .

Для получения помощи по редактированию кода пакета просмотрите документацию .





#########



# Photo Filters package for flutter

# IsMoiL Sheraliev Курсовая работа Разработка приложения «Обработка изображения фильтрами»

A flutter package for iOS and Android for applying filter to an image. A set of preset filters are also available. You can create your own filters too.

## Installation

First, add `photofilters` and `image` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### iOS

No configuration required - the plugin should work out of the box.

### Android

No configuration required - the plugin should work out of the box.

### Example

``` dart
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

```

## UI Screen Shots

<img src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/screenshot.gif" width="200">


## Sample Images of Filters

| | | | |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
| <img width="1604" alt="No Filter" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/No Filter.jpg">  No Filter | <img width="1604" alt="AddictiveBlue" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/AddictiveBlue.jpg">  AddictiveBlue | <img width="1604" alt="AddictiveRed" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/AddictiveRed.jpg">  AddictiveRed | <img width="1604" alt="Aden" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Aden.jpg">  Aden  | 
| <img width="1604" alt="Amaro" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Amaro.jpg">  Amaro | <img width="1604" alt="Ashby" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Ashby.jpg">  Ashby | <img width="1604" alt="Brannan" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Brannan.jpg">  Brannan | <img width="1604" alt="Brooklyn" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Brooklyn.jpg">  Brooklyn  | 
| <img width="1604" alt="Charmes" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Charmes.jpg">  Charmes | <img width="1604" alt="Clarendon" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Clarendon.jpg">  Clarendon | <img width="1604" alt="Crema" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Crema.jpg">  Crema | <img width="1604" alt="Dogpatch" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Dogpatch.jpg">  Dogpatch  | 
| <img width="1604" alt="Earlybird" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Earlybird.jpg">  Earlybird | <img width="1604" alt="1977" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/1977.jpg">  1977 | <img width="1604" alt="Gingham" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Gingham.jpg">  Gingham | <img width="1604" alt="Ginza" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Ginza.jpg">  Ginza  | 
| <img width="1604" alt="Hefe" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Hefe.jpg">  Hefe | <img width="1604" alt="Helena" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Helena.jpg">  Helena | <img width="1604" alt="Hudson" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Hudson.jpg">  Hudson | <img width="1604" alt="Inkwell" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Inkwell.jpg">  Inkwell  | 
| <img width="1604" alt="Juno" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Juno.jpg">  Juno | <img width="1604" alt="Kelvin" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Kelvin.jpg">  Kelvin | <img width="1604" alt="Lark" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Lark.jpg">  Lark | <img width="1604" alt="Lo-Fi" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Lo-Fi.jpg">  Lo-Fi  | 
| <img width="1604" alt="Ludwig" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Ludwig.jpg">  Ludwig | <img width="1604" alt="Maven" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Maven.jpg">  Maven | <img width="1604" alt="Mayfair" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Mayfair.jpg">  Mayfair | <img width="1604" alt="Moon" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Moon.jpg">  Moon  | 
| <img width="1604" alt="Nashville" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Nashville.jpg">  Nashville | <img width="1604" alt="Perpetua" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Perpetua.jpg">  Perpetua | <img width="1604" alt="Reyes" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Reyes.jpg">  Reyes | <img width="1604" alt="Rise" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Rise.jpg">  Rise  | 
| <img width="1604" alt="Sierra" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Sierra.jpg">  Sierra | <img width="1604" alt="Skyline" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Skyline.jpg">  Skyline | <img width="1604" alt="Slumber" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Slumber.jpg">  Slumber | <img width="1604" alt="Stinson" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Stinson.jpg">  Stinson  | 
| <img width="1604" alt="Sutro" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Sutro.jpg">  Sutro | <img width="1604" alt="Toaster" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Toaster.jpg">  Toaster | <img width="1604" alt="Valencia" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Valencia.jpg">  Valencia | <img width="1604" alt="Vesper" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Vesper.jpg">  Vesper  | 
| <img width="1604" alt="Walden" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Walden.jpg">  Walden | <img width="1604" alt="Willow" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Willow.jpg">  Willow | <img width="1604" alt="X-Pro II" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/X-Pro II.jpg">  X-Pro II  | |


## Sample Images of Convolution Filters

| | | | |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
| <img width="1604" alt="Identity" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Identity.jpg">  Identity | <img width="1604" alt="Emboss" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Emboss.jpg">  Emboss | <img width="1604" alt="Sharpen" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Sharpen.jpg">  Sharpen | <img width="1604" alt="Colored Edge Detection" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Colored%20Edge%20Detection.jpg">  Colored Edge Detection
| <img width="1604" alt="Blur" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Blur.jpg">  Blur | <img width="1604" alt="Edge Detection Medium" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Edge%20Detection%20Medium.jpg">  Edge Detection Medium | <img width="1604" alt="Edge Detection Hard" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Edge%20Detection%20Hard.jpg">  Edge Detection Hard | <img width="1604" alt="Guassian Blur" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Guassian%205x5.jpg">  Guassian Blur  | 
| <img width="1604" alt="Low Pass" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Low%20Pass%205x5.jpg">  Low Pass | <img width="1604" alt="High Pass" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/High%20Pass%203x3.jpg">  High Pass | <img width="1604" alt="Mean" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/convolution/Mean%205x5.jpg">  Mean | |


## Filters

There are two types of filters. `ImageFilter` and `ColorFilter`.

### Image Filter

Image filter applies its subfilters directly to the whole image one by one. It is computationally expensive since the complexity & time increases as the number of  subfilters increases.

You can create your own custom image filter as like this:

```dart
    import 'package:photofilters/filters/image_filters.dart';

    var customImageFilter = new ImageFilter(name: "Custom Image Filter");
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      coloredEdgeDetectionKernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      gaussian7x7Kernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      sharpenKernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      highPass3x3Kernel,
    ));
    customImageFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      lowPass3x3Kernel,
    ));
    customImageFilter.subFilters.add(SaturationSubFilter(0.5));
```

You can also inherit the ImageFilter class to create another image filter.

```dart

class MyImageFilter extends ImageFilter {
  MyImageFilter(): super(name: "My Custom Image Filter") {
    this.addSubFilter(ConvolutionSubFilter.fromKernel(sharpenKernel));
  }
}
```

### Color Filter

Color filter applies its subfilters to each pixel one by one. It is computationally less expensive than the ImageFilter. It will loop through the image pixels only once irrespective of the number of subfilters.


You can create your own custom color filter as like this:

```dart
    import 'package:photofilters/filters/color_filters.dart';

    var customColorFilter = new ColorFilter(name: "Custom Color Filter");
    customColorFilter.addSubFilter(SaturationSubFilter(0.5));
    customColorFilter
        .addSubFilters([BrightnessSubFilter(0.5), HueRotationSubFilter(30)]);

```

You can inherit the ColorFilter class too

```dart

class MyColorFilter extends ColorFilter {
  MyColorFilter() : super(name: "My Custom Color Filter") {
    this.addSubFilter(BrightnessSubFilter(0.8));
    this.addSubFilter(HueRotationSubFilter(30));
  }
}

```

## Sub filters

There are two types of subfilters. One can be added to the `ColorFilter` and the other can be added to the `ImageFilter`. You can inherit `ColorSubFilter` class to implement the former and you can use the `ImageSubFilter` mixin to implement the latter. You can create a same subfilter that can be used for both Image and Color Filters. The `BrightnessSubFilter` is an example of this.

```dart
class BrightnessSubFilter extends ColorSubFilter with ImageSubFilter {
  final num brightness;
  BrightnessSubFilter(this.brightness);

  ///Apply the [BrightnessSubFilter] to an Image.
  @override
  void apply(Uint8List pixels, int width, int height) =>
      image_filter_utils.brightness(pixels, brightness);

  ///Apply the [BrightnessSubFilter] to a color.
  @override
  RGBA applyFilter(RGBA color) =>
      color_filter_utils.brightness(color, brightness);
}
```


## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).

