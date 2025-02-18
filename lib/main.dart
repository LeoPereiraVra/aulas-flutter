import 'package:app/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(                
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = "";  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("APP AULA FLUTTER"),
        ),
        body: Center(
          
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              TextField(onChanged: (value) {
                setState(() {
                  _counter = value;
                });
              },),
              Center(
                child: Column(
                  children: [
                    Container(child: Text("Aula flutter",style: TextStyle(fontSize: 50))),
                    Container(child: Text(_counter,style: TextStyle(fontSize: 50))),
                  ],
                ),
              )
            ],
          ),
        ),        
        floatingActionButton: FloatingActionButton(          
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        }),
    );
  }
}


// AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(          
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
