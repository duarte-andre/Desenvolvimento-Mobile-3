import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knob_widget/knob_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(App_Knob());
}

class App_Knob extends StatelessWidget {
  const App_Knob({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Aula05 - Knob",
      theme:  ThemeData.dark(),
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _minimo =0; // variaveis para o knob
  final double _maximo =100; // variaveis para o knob

  late KnobController controller;

  late double _knobvalue;

  void valueChangedListener(double value){
    if (mounted){
      setState(() {
        _knobvalue = value;
      });
    }
  }
  @override
  void initState(){
  super.initState();
  _knobvalue = _minimo; //valor inicial do knob
  controller = KnobController(
    initial: _knobvalue,//valor inicial
    minimum: _minimo,//valor minimo
    maximum: _maximo,//valor maximo
    startAngle: 0,//Angulo inicial
    endAngle: 180,//Angulo final
    precision: 2,//Precisão do knob
  );
  controller.addOnValueChangedListener(valueChangedListener);

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Knob e Gauge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Text('Knob value: ${_knobvalue.toStringAsFixed(2)}'),
            ElevatedButton(onPressed: (){
              var value = Random().nextDouble() * (_maximo - _minimo) + _minimo;
              controller.setCurrentValue(value);
        
            }, child: Text('knob Value')),
            Container(
              // widget knob
              child: Knob(
                controller: controller,
                width: 200,
                height: 200,

              ),
            ),
            SizedBox(
              width: 300,
              height: 300,
              //SfRadialGauge - elemento  gauge
              child: SfRadialGauge(
                title: GaugeTitle(
                  text: 'Knob Value',
                  textStyle: TextStyle(fontSize: 20.0,
                  fontWeight: FontWeight.bold)
                  ),
                  axes:<RadialAxis> [
                    RadialAxis(
                      minimum: _minimo,
                      maximum: _maximo,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 50,
                          color: Colors.green,
                          startWidth:10,
                          endWidth: 10
                         ),
                         GaugeRange(
                          startValue: 50,
                          endValue: 100,
                          color: Colors.orange,
                          startWidth:10,
                          endWidth: 10
                          ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          //value - variavel do gauge
                          //knobvalue - variavel do knob
                          value: _knobvalue,
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Container(
                            child: Text('${_knobvalue.toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 25,
                            fontWeight: FontWeight.bold),
                            ),
                            
                          ),
                          angle: 90,
                          positionFactor: 0.5,
                          ),
                      ],
                    )

                  ],
              ),

            )
          ],
        ),
      ),
    );
   
  }
   @override
    void dispose(){
      controller.removeOnValueChangedListener(valueChangedListener);
      super.dispose();    }
}
