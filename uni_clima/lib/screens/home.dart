import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:uni_clima/model/clima_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ClimaModel climaModel;

  final List<String> _cidades = [
    "Aracaju",
    "Belém",
    "Belo Horizonte",
    "Boa Vista",
    "Brasilia",
    "Campo Grande",
    "Cuiaba",
    "Curitiba",
    "Florianopolis",
    "Fortaleza",
    "Goiânia",
    "João Pessoa",
    "Macapá",
    "Maceió",
    "Manaus",
    "Natal",
    "Palmas",
    "Porto Alegre",
    "Porto Velho",
    "Recife",
    "Rio Branco",
    "Rio de Janeiro",
    "Salvador",
    "São Luiz",
    "São Paulo",
    "Teresina",
    "Vitória"
  ];

  String _cidadeSelecionada = "São Paulo";

  carregaClima() async {
    const String _appid = ""; //SUA chave da API
    const String _lang = "pt_br";
    const String _units = "metric";
    const String _apiURL = "api.openweathermap.org";
    const String _path = "/data/2.5/weather";

    final _parametros = {
      "q": _cidadeSelecionada,
      "appid": _appid,
      "lang": _lang,
      "units": _units
    };

    final climaResponse =
        await http.get(Uri.https(_apiURL, _path, _parametros));

    //Apenas para verificar se a URL foi montada adequadamente:
    //print('Url montada: ' + climaResponse.request.url.toString());

    if (climaResponse.statusCode == 200) {
      setState(() {
        climaModel = ClimaModel.fromJson(jsonDecode(climaResponse.body));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cidadeSelecionada),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [_buildList(_cidades)],
        ),
      ),
    );
  }

  Widget _buildList(List<String> listData) {
    return DropdownSearch<String>(
      mode: Mode.MENU,
      showSelectedItems: true,
      maxHeight: MediaQuery.of(context).size.height - 100,
      items: listData,
      showSearchBox: true,
      onChanged: (value) {
        setState(() {
          if (value == null || value == "") {
            _cidadeSelecionada = "Selecione uma cidade";
          } else {
            _cidadeSelecionada = value;
            carregaClima();
          }
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? "Selecione uma cidade" : null,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      showClearButton: true,
      clearButton: const Icon(Icons.close),
    );
  }
}
