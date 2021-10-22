import 'package:flutter/material.dart';
import 'package:uni_clima/model/clima_model.dart';

class ClimaWidget extends StatelessWidget {
  final ClimaModel climaModel;

  const ClimaWidget({Key? key, required this.climaModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "http://openweathermap.org/img/wn/${climaModel.icon}@2x.png",
          fit: BoxFit.fill,
          width: 100,
        ),
        Text(
          "${climaModel.temperatura.toStringAsFixed(0)}ºC",
          style: const TextStyle(fontSize: 50),
        ),
        Text(
          climaModel.descClima,
          style: const TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        Text(
          "Mín. do dia: ${climaModel.tempMin.toStringAsFixed(0)}ºC",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Text(
          "Max. do dia: ${climaModel.tempMax.toStringAsFixed(0)}ºC",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Text(
          "Sensação Térmica: ${climaModel.sensacaoTermica.toStringAsFixed(0)}ºC",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        //paramos aqui, falta monstar as demais informações do clima...
      ],
    );
  }
}
