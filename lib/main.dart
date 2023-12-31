import 'package:flutter/material.dart';
import 'vivan-stepper-code.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Stepper Sample')),
        body: const Center(
          child: Example(),
        ),
      ),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _index = 0;
  int? _hoveredIndex;
  final activeColor = Color(0xFF000041);

  final List<VivanStep> steps = [
    VivanStep(
      isActive: false,
      label: Text(
        "Checking sequencing data",
        style: TextStyle(color: Colors.grey),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      title: SizedBox.shrink(),
      content: Text("Content for Step 1"),
      state: VivanStepState.editing,
    ),
    VivanStep(
      isActive: false,
      label: Text(
        "Sequencing data OK",
        style: TextStyle(color: Colors.grey),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      title: SizedBox.shrink(),
      content: Text("Test"),
      state: VivanStepState.complete,
    ),
    VivanStep(
      isActive: false,
      label: Text(
        "Download sequencing report",
        style: TextStyle(color: Colors.grey),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      title: SizedBox.shrink(),
      content: Text("Content for Step 3"),
      state: VivanStepState.editing,
    ),
    VivanStep(
      isActive: true,
      label: Text(
        "Download treatment report",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      title: SizedBox.shrink(),
      content: Text("Content for Step 4"),
      state: VivanStepState.complete,
    ),
  ];

  Widget customIconBuilder(int index, dynamic) {
    final label = steps[index].label as Text;
    final isActive = steps[index].isActive;
    bool shouldEnableHover = label.data?.startsWith("Download") ?? false;

    Color iconColor;
    if (_hoveredIndex == index && shouldEnableHover) {
      iconColor = Color(0xFF00BEB9); // hover color
    } else if (isActive) {
      iconColor = Colors.grey[300]!; // color for active icon
    } else if (label.data?.startsWith("Download") ?? false) {
      iconColor = activeColor;
    } else {
      iconColor = Colors.grey[300]!;
    }

    Icon icon;
    switch (label.data) {
      case "Checking sequencing data":
        icon = Icon(Icons.science_outlined, color: iconColor);
        break;
      case "Download recommendations treatment report":
        icon = Icon(Icons.task_outlined, color: iconColor);
        break;
      case "Download sequencing report":
        icon = Icon(Icons.file_download_outlined, color: iconColor);
        break;
      case "Sequencing data OK":
        icon = Icon(Icons.thumb_up_alt_outlined, color: iconColor);
        break;
      default:
        icon = Icon(Icons.question_mark_outlined, color: iconColor);
        break;
    }

    BoxDecoration decoration = BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    );

    //The below 'Stack' is to cover the default grey circle on the steps
    final iconWidget = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (!isActive)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        icon,
      ],
    );

    return shouldEnableHover
        ? MouseRegion(
            onEnter: (_) {
              setState(() {
                _hoveredIndex = index;
              });
            },
            onExit: (_) {
              setState(() {
                _hoveredIndex = null;
              });
            },
            child: iconWidget,
          )
        : iconWidget;
  }

  @override
  Widget build(BuildContext context) {
    return VivanStepper(
      type: VivanStepperType.horizontal,
      stepIconBuilder: customIconBuilder,
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        if (steps[index].isActive) {
          setState(() {
            _index = index;
          });
        }
      },
      steps: steps,
    );
  }
}
