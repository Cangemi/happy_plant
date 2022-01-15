import 'dart:async';

//import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:happy_plant/widgets/WidgetAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{


  //SpriteComponent plant = SpriteComponent();

  late Future <Map> _future = _request();
  String text1 = "Me dê um copo d'água!\n";
  String text2 = "To suave!\n";
  int p = 0;

  Future<Map> _request() async{
    var url = "https://api.thingspeak.com/channels/1630562/fields/1.json?api_key=MEIRVBR72ZRVB2CA&results=2";
    http.Response response;

    response = await http.get(Uri.parse(url));

    print("Map: ${response.body}");

    Map<String, dynamic> map = json.decode(response.body);
    String percentage = map["feeds"][0]["field1"];
    print("Porcentagem: ${percentage}");
    return json.decode(response.body);
  }

  setUpTimedFetch() {
   Timer.periodic(Duration(milliseconds: 5000), (timer) {
      setState(() {
          _future = _request();
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpTimedFetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _future,
        builder: (context,snapshot){

          String porcentagem = '';

        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasError){
              print("Houve um erro");
            }else{
              porcentagem = snapshot.data?["feeds"][1]["field1"];
              p= int.parse(porcentagem);

            }
            break;

        }
     //   String data = porcentagem.toString();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Happy Plant",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: p < 5? Image.asset("assets/images/triste.png")
                        : WidgetAnimation(address: "assets/images/sprite_feliz_", length: 4, duration: 100,),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    p< 30? text1 + porcentagem : text2 + porcentagem,
                    style: TextStyle(
                        fontSize: 25
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        },
    );
  }
}
