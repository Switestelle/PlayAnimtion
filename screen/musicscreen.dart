//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MusicScreen extends StatefulWidget {
   const MusicScreen({ Key? key }) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {


  SMIInput<bool>? _playButtonInput;
  Artboard? _playButtonArtboard;

  void _playTrackChangeAnimation(RiveAnimationController controller) {
    if (controller.isActive == false) {
       controller.isActive = true;
    }
  }

void _playButtonAnimation() {
  if (_playButtonInput ?.value == false &&
      _playButtonInput ?.controller.isActive == false) {
     _playButtonInput ?.value = true;   
      }else if(_playButtonInput ?.value == true && 
      _playButtonInput ?.controller.isActive == false) {
    _playButtonInput ?.value = false;
      }
}

  @override
  void initState() {

    rootBundle.load("assets/play.riv").then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller =
       StateMachineController.fromArtboard(
        artboard, 
        "PlayPauseButton",
        );
        if (controller != null) {
          artboard.addController(controller);
          _playButtonInput = controller.findInput("isPlaying");
        }
        setState(
          () => _playButtonArtboard = artboard,
           );
    });
  }



      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color.fromARGB(255, 36, 34, 154), 
     body: Column(
       children: [
         const SizedBox(
          height: 60,
         ),
         _playButtonArtboard == null ? const SizedBox() :
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTapDown: (_) => _playButtonAnimation(),
                child:  SizedBox(
                  height: 120,
                  width: 120,
                  child: Rive(
                    artboard: _playButtonArtboard!,
                   fit: BoxFit.fitHeight,
                    ),
                ),
            )
          ],
         )
       ],
     ),
    );    
  }
}