import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/bloc/counter_bloc.dart';
import 'package:simplebloc/bloc/counter_event.dart';
import 'package:simplebloc/bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
          if (state is CounterInit) {
            return _view(context, 0);
          }
          if (state is CounterUpdate) {
            return _view(context, state.counter);
          }
          return Container();
        }));
  }
}

Widget _view(BuildContext context, int value) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          value.toString(),
        ),
        Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(CounterIncrease());
              },
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(CounterDecrease());
              },
              child: Icon(Icons.minimize),
            )
          ],
        ),
      ],
    ),
  );
}
