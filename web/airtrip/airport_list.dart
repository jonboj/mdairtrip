
import 'dart:html';

import 'package:mdcdavan/mdcdavan.dart';

class AirportData {
  final String iata;
  final String name;
  final String country;
  final double long;
  final double lat;
  const AirportData(final String this.iata, final String this.name, final String this.country,
      final double this.lat, final double this.long);
}

const List<AirportData> AIRPORT_LIST_DATA = [
  const AirportData('PEK', 'Beijing Capital International Airport', 'China', 40.072444, 116.597497),
  const AirportData('AMS', 'Amsterdam Schiphol Airport', 'Netherlands', 52.308613, 4.763889),
  const AirportData('SVO', 'Sheremetyevo International Airport', 'Russian Federation', 55.972642, 37.414589),
  const AirportData('GRU', 'São Paulo-Guarulhos International Airport', 'Brazil', -23.432075, -46.469511),
  const AirportData('LAX', 'Los Angeles International Airport', 'United States', 33.942495, -118.408068),
  const AirportData('JFK', 'John F Kennedy International Airport', 'United States', 40.639751, -73.778926)
];

class AirportList extends MdaNodeElem {

  final List<AirportData> _airportList;
  final MdcList _list;

  AirportList(final List<AirportData> this._airportList):
        _list = buildMdcList(_airportList),
        super(new DivElement()){
    buildWithChilds([_list]);
  }

  Stream<int> menuSelectStream() => _list.selectStream();

  static MdcList buildMdcList(final List<AirportData> airportList) {
    final List<MdcListItem> menuList =
    airportList.map((AirportData apd) => new MdcListItem(apd.iata + ' ' + apd.name, 'flight')).toList();
    return new MdcList(menuList);
  }

  AirportData getFromList(int index) =>
      _airportList[index];
}