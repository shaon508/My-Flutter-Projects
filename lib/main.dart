import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      home: const HomeActivity(),
    );
  }
}

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => BmiCalculator();
}

class BmiCalculator extends State<HomeActivity> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();

  var result = "";
  var bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 250,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            "https://img.freepik.com/free-vector/gradient-bmi-infographic_23-2150143471.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 300,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      TextField(
                        controller: wtController,
                        decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                          prefixIcon: Icon(Icons.line_weight),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: ftController,
                        decoration: InputDecoration(
                          labelText: 'Height (ft)',
                          prefixIcon: Icon(Icons.height),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: inController,
                        decoration: InputDecoration(
                          labelText: 'Height (in)',
                          prefixIcon: Icon(Icons.height),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          var wt = wtController.text;
                          var ft = ftController.text;
                          var inch = inController.text;
                          if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
                            var intWt = int.parse(wt);
                            var intFt = int.parse(ft);
                            var intInch = int.parse(inch);

                            var totalInch = intFt * 12 + intInch;
                            var convertToMeter = 0.0254 * totalInch;

                            var bmi = intWt / (convertToMeter * convertToMeter);
                            var msg = "";
                            Color newColor;
                            if (bmi < 18.5) {
                              msg = "You're Underweight!";
                              newColor = Colors.amber.shade50;
                            } else if (bmi < 25) {
                              msg = "Normal!";
                              newColor = Colors.amber.shade200;
                            } else if (bmi < 30) {
                              msg = "Overweight!";
                              newColor = Colors.red.shade100;
                            } else if (bmi < 40) {
                              msg = "Obesity!";
                              newColor = Colors.red.shade800;
                            } else {
                              msg = "Extreme Obesity!";
                              newColor = Colors.red;
                            }
                            setState(() {
                              result = "$msg \n Your BMI is: ${bmi.toStringAsFixed(2)}";
                              bgColor = newColor;
                            });
                          } else {
                            setState(() {
                              result = "Please fill all required fields!";
                              bgColor = Colors.white;
                            });
                          }
                        },
                        child: Text("Calculate"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        result,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
