import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/rendering.dart';

import 'StudentClassScreen.dart';

class AssignmentScreen extends StatefulWidget {
  static const routeName = '/assignmentScreen';
  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  GlobalKey _key = GlobalKey();
  bool _finished;
  PainterController _controller;

  @override
  void initState() {
    super.initState();
    _finished = false;
    _controller = _newController();
  }

  saveImage(path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('assignmentImage', path);
    print('canvas image Result: ............ ' + path);
  }


  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.white;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        new IconButton(
          icon: new Icon(Icons.content_copy),
          tooltip: 'New Painting',
          onPressed: () => setState(() {
            _finished = false;
            _controller = _newController();
          }),
        ),
      ];
    } else {
      actions = <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.undo,
            ),
            tooltip: 'Undo',
            onPressed: () {
              if (_controller.isEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        new Text('Nothing to undo'));
              } else {
                _controller.undo();
              }
            }),
        new IconButton(
            icon: new Icon(Icons.delete),
            tooltip: 'Clear',
            onPressed: _controller.clear),
        new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => _show(_controller.finish(), context)),
      ];
    }
    return new Scaffold(
      appBar: new AppBar(
          title: const Text('Painter Example'),
          actions: actions,
          bottom: new PreferredSize(
            child: new DrawBar(_controller),
            preferredSize: new Size(MediaQuery.of(context).size.width, 30.0),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child:
            new AspectRatio(aspectRatio: 1.0, child: new Painter(_controller)),
      ),
    );
  }

  Future<void> _save() async {
    RenderRepaintBoundary boundary =
        _key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    //Request permissions if not already granted
    if (!(await Permission.storage.status.isGranted))
      await Permission.storage.request();
    
    final number = DateTime.now().toString();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 60,
        name: "canvas_image$number");

        saveImage(result);
  }

  void _show(PictureDetails picture, BuildContext context) {
    setState(() {
      _finished = true;
    });
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: const Text('View your homework'),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(108, 73, 73, 1),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(AssignmentScreen.routeName);
                    },
                    child: Text(
                      'Undo Homework',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(108, 73, 73, 1),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _save();
                      Navigator.of(context).pushReplacementNamed(StudentClassScreen.routeName);
                    },
                    child: Text(
                      'Submit Homework',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            RepaintBoundary(
              key: _key,
                          child: Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: new FutureBuilder<Uint8List>(
                    future: picture.toPNG(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Uint8List> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return new Text('Error: ${snapshot.error}');
                          } else {
                            return Image.memory(snapshot.data);
                          }
                          break;
                        default:
                          return new Container(
                              child: new FractionallySizedBox(
                            widthFactor: 0.1,
                            child: new AspectRatio(
                                aspectRatio: 1.0,
                                child: new CircularProgressIndicator()),
                            alignment: Alignment.center,
                          ));
                      }
                    },
                  ),),
            ),
            SizedBox(height: 30),
          ],
        ),
      );
    }));
  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(child: new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new Container(
              child: new Slider(
            value: _controller.thickness,
            onChanged: (double value) => setState(() {
              _controller.thickness = value;
            }),
            min: 1.0,
            max: 20.0,
            activeColor: Colors.white,
          ));
        })),
        new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new RotatedBox(
              quarterTurns: _controller.eraseMode ? 2 : 0,
              child: IconButton(
                  icon: new Icon(Icons.create),
                  tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                      ' eraser',
                  onPressed: () {
                    setState(() {
                      _controller.eraseMode = !_controller.eraseMode;
                    });
                  }));
        }),
        new ColorPickerButton(_controller, false),
        new ColorPickerButton(_controller, true),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => new _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                  appBar: new AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: new Container(
                      alignment: Alignment.center,
                      child: new ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
