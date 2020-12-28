import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController controller1;
  TextEditingController controller2;
  TextEditingController controller3;

  String result;
  var _eventChannel = EventChannel('com.mufeng.flutterNativeChannel.EventChannel');
  String second = '0';
  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    _eventChannel.receiveBroadcastStream().listen(_listen, onError: (value){
      print(value);
    });
  }

  void _listen(event) {
    setState(() {
      second = event['count'].toString();
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter与Native通信'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(child: TextField(
                  controller: controller1,
                  keyboardType: TextInputType.number,
                )),
                SizedBox(width: 10,),
                Expanded(child: TextField(
                  controller: controller2,
                  keyboardType: TextInputType.number,
                )),
                SizedBox(width: 10,),
                Expanded(child: TextField(
                  controller: controller3,
                  keyboardType: TextInputType.number,
                )),
                SizedBox(width: 10,),
              ],
            ),
            TextButton(onPressed: ()async{
              /// 保证平台channel保持一致
              var channel = MethodChannel('com.mufeng.flutterNativeChannel.MethodChannel');
              var result = await channel
                  .invokeMethod('add', {'params1': int.parse(controller1.text), 'params2': int.parse(controller2.text), 'params3': int.parse(controller3.text)});
              setState(() {
                this.result = result.toString();
              });
            }, child: Text('数字相加')),
            Text('返回数字相加结果: $result'),
            Text('实时接收监听的数据: $second')
          ],
        ),
      ),
    );
  }


}

