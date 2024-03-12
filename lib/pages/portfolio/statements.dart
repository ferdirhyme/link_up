import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:page_route_animator/page_route_animator.dart';

import '../../constants/platforms.dart';
import '../../constants/widgets.dart';
import '../../uploadData/data.dart';

class Statements extends StatefulWidget {
  const Statements({super.key});

  @override
  State<Statements> createState() => _StatementsState();
}

class _StatementsState extends State<Statements> {
  final TextEditingController _historyController = TextEditingController();
  final TextEditingController _missionController = TextEditingController();
  final TextEditingController _visionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int missionCounter = 500;
  int visionCounter = 500;
  int historyCounter = 500;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: checkForPlatForm() == 'android' ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 1.5,
            child: Column(
              children: [
                myTextArea(
                    label: 'Brief Overview (History)',
                    myTextController: _historyController,
                    preFixIcon: const Icon(Icons.history),
                    inputformat: [
                      LengthLimitingTextInputFormatter(
                        500,
                      ),
                    ],
                    counter: historyCounter.toString(),
                    typedCharacterFunction: (String value) {
                      setState(() {
                        historyCounter = 500 - value.length;
                      });
                    }),

                myTextArea(
                    label: 'Mission Statement',
                    myTextController: _missionController,
                    preFixIcon: const Icon(Icons.announcement),
                    inputformat: [
                      LengthLimitingTextInputFormatter(
                        500,
                      ),
                    ],
                    counter: missionCounter.toString(),
                    typedCharacterFunction: (String value) {
                      setState(() {
                        missionCounter = 500 - value.length;
                      });
                    }),
                myTextArea(
                    label: 'Vision Statement',
                    myTextController: _visionController,
                    preFixIcon: const Icon(Icons.announcement),
                    inputformat: [
                      LengthLimitingTextInputFormatter(
                        500,
                      ),
                    ],
                    counter: visionCounter.toString(),
                    typedCharacterFunction: (String value) {
                      setState(() {
                        visionCounter = 500 - value.length;
                      });
                    }),
                    const Gap(20),
                     myButton(
              formKey: formKey,
              label: 'Next',
              function: () {
                data['mission'] = _missionController.text;
                data['vision'] = _visionController.text;
                data['history'] = _historyController.text;
                
                Navigator.push(
                  context,
                  PageRouteAnimator(
                    child: const Statements(),
                    routeAnimation: RouteAnimation.bottomLeftToTopRight,
                    settings: const RouteSettings(arguments: ''),
                    curve: Curves.easeOut,
                  ),
                );
              },
              icon: const Icon(Icons.navigate_next),
            )
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
