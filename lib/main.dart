import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GASOLINA',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Diferencia del precio del combustible'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerPrecioCR;
  TextEditingController controllerPrecioPN;
  TextEditingController controllerValorDolar;
  TextEditingController controllerCantidad;
  var txt = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerPrecioCR = new TextEditingController();
    controllerPrecioPN = new TextEditingController();
    controllerValorDolar = new TextEditingController();
    controllerCantidad = new TextEditingController();
  }

  @override
  void dispose() {
    controllerPrecioCR.dispose();
    controllerPrecioPN.dispose();
    controllerValorDolar.dispose();
    controllerCantidad.dispose();
    super.dispose();
  }

  double valores(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      return double.parse(controller.text);
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => pageAcercaDe(
                              title: "Acerca de...",
                            )),
                  );
                },
                child: Icon(Icons.contact_support_outlined),
              )),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.grey[300],
          height: size.height * 1,
          width: size.width * 1,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
                      child: CircleAvatar(
                        radius: 50,
                        child: IconButton(
                          iconSize: 80,
                          icon: const Icon(
                            Icons.local_gas_station,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() {
                            controllerPrecioCR.clear();
                            controllerPrecioPN.clear();
                            controllerValorDolar.clear();
                            controllerCantidad.clear();
                          }),
                        ),
                      ),
                    ),
                  ]),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 5),
                    child: TextField(
                        controller: controllerPrecioCR,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            labelText:
                                'Precio por litro en Costa Rica (Colones)',
                            icon: Icon(Icons.local_gas_station_sharp))),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 5),
                    child: TextField(
                        controller: controllerPrecioPN,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            labelText: 'Precio por litro en Panamá (Dolares)',
                            icon: Icon(Icons.local_gas_station_sharp))),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 5),
                    child: TextField(
                        controller: controllerValorDolar,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            labelText: 'Valor del dolar en colones',
                            icon: Icon(Icons.money))),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 5),
                    child: TextField(
                        controller: controllerCantidad,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            labelText: 'Cantidad que dinero que desea echar',
                            icon: Icon(Icons.monetization_on_rounded))),
                  ),

                  //Button Login
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(100, 15, 100, 15),
                    child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calculate,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            " Calcular",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ],
                      ),
                      onPressed: () {
                        String msg = "Acceso no permitido";

                        double resultadoCr = 0.0;
                        double resultadoPn = 0.0;
                        try {
                          double precioCr = valores(controllerPrecioCR);
                          double PrecioPn = valores(controllerPrecioPN);
                          double dolar = valores(controllerValorDolar);
                          double cantidad = valores(controllerCantidad);

                          if (controllerCantidad.text.isNotEmpty &&
                              controllerValorDolar.text.isNotEmpty &&
                              controllerPrecioCR.text.isNotEmpty &&
                              controllerPrecioPN.text.isNotEmpty) {
                            resultadoCr = cantidad / precioCr;
                            resultadoPn = (cantidad / dolar) / PrecioPn;

                            if (resultadoPn < resultadoCr) {
                              msg = "Mejor opcion es CR... \n" +
                                  "Litros en Costa Rica: " +
                                  resultadoCr.toStringAsFixed(3).toString() +
                                  "\n" +
                                  "Litros en Panamá: " +
                                  resultadoPn.toStringAsFixed(3).toString() +
                                  "\n" +
                                  "Cambio en dolares: " + 
                                  (cantidad / dolar)
                                      .toStringAsFixed(3)
                                      .toString() +
                                  " dolares";
                            } else {
                              msg = "Mejor opcion es Panamá... \n" +
                                  "Litros en Panamá: " +
                                  resultadoPn.toStringAsFixed(3).toString() +
                                  "\n" +
                                  "Litros en Costa Rica: " +
                                  resultadoCr.toStringAsFixed(3).toString() +
                                  "\n" +
                                  "Cambio en dolares: " +
                                  (cantidad / dolar)
                                      .toStringAsFixed(3)
                                      .toString() +
                                  " dolares";
                            }
                          } else if (controllerCantidad.text.isNotEmpty &&
                              controllerPrecioCR.text.isNotEmpty) {
                            resultadoCr = cantidad / precioCr;
                            msg = "Costa Rica... \n" +
                                "Litros en Costa Rica: " +
                                resultadoCr.toStringAsFixed(3).toString() +
                                "\n" +
                                "Cambio en dolares: " +
                                (cantidad / dolar)
                                    .toStringAsFixed(3)
                                    .toString() +
                                " dolares";
                          } else if (controllerCantidad.text.isNotEmpty &&
                              controllerPrecioPN.text.isNotEmpty &&
                              controllerValorDolar.text.isNotEmpty) {
                            resultadoPn = (cantidad / dolar) / PrecioPn;
                            msg = "Panamá (Pagando en colones)... \n" +
                                "Litros en Panamá: " +
                                resultadoPn.toStringAsFixed(3).toString() +
                                "\n" +
                                "Cambio en dolares: " +
                                (cantidad / dolar)
                                    .toStringAsFixed(3)
                                    .toString() +
                                " dolares";
                          } else if (controllerCantidad.text.isNotEmpty &&
                              controllerPrecioPN.text.isNotEmpty) {
                            resultadoPn = cantidad / PrecioPn;
                            msg = "Panamá... \n" +
                                "Litros en Panamá: " +
                                resultadoPn.toStringAsFixed(3).toString();
                          } else {
                            msg = "No hay datos suficientes.";
                          }
                        } on Exception catch (_) {
                          msg = "ELEMENTOS INVÁLIDOS EN LAS CASILLAS \n" +
                              "Revise si hay campos vacíos o comas en lugar de puntos.";
                        }
                        Fluttertoast.showToast(
                            msg: msg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 10,
                            backgroundColor: Colors.green[200],
                            textColor: Colors.white,
                            fontSize: 20);
                      },
                    ),
                  ),

                  Divider(
                    height: 11,
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 1, 50, 1),
                    child: TextButton(
                      onPressed: () => launch(
                          "https://gee.bccr.fi.cr/IndicadoresEconomicos/Cuadros/frmConsultaTCVentanilla.aspx"),
                      child: const Text(
                        "Tipo de cambio del Dolar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 1, 50, 1),
                    child: TextButton(
                      onPressed: () => launch(
                          "https://www.recope.go.cr/productos/precios-nacionales/tabla-precios/"),
                      child: const Text(
                        "Precio del combustible en CR",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 1, 50, 1),
                    child: TextButton(
                      onPressed: () => launch(
                          "https://www.google.com/search?q=precio+de+la+gasolina+en+panamá&client=opera-gx&hs=om2&sxsrf=APq-WBvq4BAyOxU_U-l9pbEpl6GUxmkvCQ%3A1649543249702&ei=UQhSYq64KpCEwbkP76eNYA&oq=Precio+&gs_lcp=Cgdnd3Mtd2l6EAMYADIECCMQJzIECCMQJzILCAAQgAQQsQMQgwEyCAgAEIAEELEDMhAIABCABBCHAhCxAxCDARAUMgsIABCABBCxAxCDATIICAAQgAQQsQMyDggAEIAEELEDEIMBEMkDMgUIABCSAzIFCAAQgAQ6BwgAEEcQsAM6BAguEEM6CwguEIAEELEDEIMBOg4ILhCABBCxAxDHARCjAjoRCC4QgAQQsQMQgwEQxwEQowI6BAgAEEM6CgguELEDEIMBEENKBAhBGABKBAhGGABQ9yRY6y1gijloAXABeACAAe8BiAHbCJIBBTAuNS4ymAEAoAEByAEIwAEB&sclient=gws-wiz"),
                      child: const Text(
                        "Precio de la gasolina en Panamá",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 1, 50, 1),
                    child: TextButton(
                      onPressed: () => launch(
                          "https://es.globalpetrolprices.com/diesel_prices/"),
                      child: const Text(
                        "Precio de la diesel en Panamá",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 1, 50, 1),
                    child: TextButton(
                      onPressed: () => launch(
                          "https://es.globalpetrolprices.com/gasoline_prices/"),
                      child: const Text(
                        "Global Petrol Prices",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),

                  Divider(
                    height: 11,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class pageAcercaDe extends StatefulWidget {
  pageAcercaDe({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _pageAcercaDeState createState() => _pageAcercaDeState();
}

class _pageAcercaDeState extends State<pageAcercaDe> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.grey[300],
          height: size.height * 1,
          width: size.width * 1,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Esta aplicacion tiene el propósito de facilitar los cálculos" +
                          "para saber dónde es la mejor opción para echar combustible.\n",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      "Como usar la aplicación \n ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "Opción 1... \n " +
                          "Para saber la cantidad de litros solo de Costa Rica -Digite la informacion del" +
                          "precio de combustible en Costa Rica y la cantidad de dinero que desea echar \n\n" +
                          "Opción 2... \n " +
                          "Para saber la cantidad de litros solo de Panamá echando con dolares -Digite la " +
                          "informacion del precio de combustible en Panamá y la cantidad de dinero que" +
                          "desea echar en dólares \n \n" +
                          "Opción 3... \n " +
                          "Para saber la cantidad de litros solo de Panamá echando con colones -Digite la " +
                          "informacion del precio de combustible en Panamá (en dólares), el valor del dolar en colones" +
                          "y la cantidad de dinero que desea echar en colones \n\n",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(
                      height: 1,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(50, 1, 50, 1),
                      child: TextButton(
                        onPressed: () =>
                            launch("http://mailto:brayanugalde35@gmail.com"),
                        child: const Text(
                          "Contactar por correo electronico",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 11,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
