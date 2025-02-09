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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 14, 125, 200)),
        useMaterial3: true,
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  int _counter = 0;
  bool _image = true;
  // Added animation variables
  late AnimationController _controller;
  late CurvedAnimation _animation;

  //Code for AnimationController and CurveAnimation
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3)
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //Toggle between images
  void _toggle() {
    setState(() {
      if (_image) {
        _image = false;
      } else {
        _image = true;
      }

      _controller.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            //Container and styles for the images
            if (_image)
            FadeTransition(
              opacity: _animation,
              child: Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage('https://images.pexels.com/photos/4629633/pexels-photo-4629633.jpeg'),
                    fit: BoxFit.cover,
                  )
                )
              )
            )

            else
            FadeTransition(
              opacity: _animation,
              child: Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage('https://images.pexels.com/photos/4629626/pexels-photo-4629626.jpeg'),
                    fit: BoxFit.cover,
                  )
                )
              )
            ),
              
            //Code for the ElevatedButton to toggle between the images
            ElevatedButton(
              onPressed: _toggle,
              child: const Text('Toggle Image')
            )
          ]
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )
    );
  }
}
