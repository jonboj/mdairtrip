
import 'dart:html';

import "package:mdcdavan/mdcdavan.dart";

import 'airport_list.dart';

class TripRouteList extends MdaNodeElem  {
  TripRouteList(final List<AirportData> routeList)
      : super(new DivElement(), [AirportList.buildMdcList(routeList)]);
}